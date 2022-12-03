///  File: Sources/App/Modules/User/Controllers/UserController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor

enum UserControllerError: Error {
    case idParameterMissing
    case idParameterInvalid
    case missingUser
    case invalidForm
    case unableToCreateNewRecord
    case passwordsDontMatch
    case missingPassword
    case cantAddUpdateOrDeleteRoot
    case userNameAlreadyTaken
}

/// UserController contains the endpoint functions for "/user/..." URLs.
struct UserController: RouteCollection {

    /// Endpoints map for the UserController.
    func boot(routes: RoutesBuilder) throws {
        let userRoutes = routes.grouped("user")
        userRoutes.get("index", use: index)
        userRoutes.get("add", use: add)
        userRoutes.post("save", use: save)
        userRoutes.get("show", use: show)
        userRoutes.post("update", use: update)
        userRoutes.post("delete", use: delete)
    }

    /// Pull up a list of all the users, and importantly, their UUIDs needed to link to other endpoints.
    func index(req: Request) async throws -> Response {
        let usersContext = UsersContext(many: try await UserModel.query(on: req.db).all())
        return req.templates.renderHtml(UserIndexTemplate(usersContext))
    }

    /// Demonstrates how to pass the user UUID  as a parameter of the URL, and displays as a button
    func show(req: Request) async throws -> Response {
        guard let userIdContext = try? req.query.decode(UserIdContext.self) else {
            throw UserControllerError.idParameterMissing
        }
        guard let userId = UUID(uuidString: userIdContext.id) else {
            throw UserControllerError.idParameterInvalid
        }
        guard let user = try await UserModel.find(userId, on: req.db) else {
            throw UserControllerError.missingUser
        }
        return req.templates.renderHtml(UserShowTemplate(UserContext(model: user)))
    }

    /// Shows how to present an HTML template to enter a new user.
    func add(req: Request) -> Response {
        return req.templates.renderHtml(UserAddTemplate())
    }

    /// Shows how to retrieve the new user from the "add" page.
    /// Because this is a new user, it must have a password -- other restrinctions on the password could also be added here.
    func save(req: Request) async throws -> Response {
        var userIdContextWithPassword = UserIdContextWithPassword()
        do {
            userIdContextWithPassword = try req.content.decode(UserIdContextWithPassword.self)
        } catch { throw UserControllerError.invalidForm }

        // Check the password
        guard userIdContextWithPassword.password != "" else {
            throw UserControllerError.missingPassword
        }
        guard userIdContextWithPassword.password == userIdContextWithPassword.confirmPassword else {
            throw UserControllerError.passwordsDontMatch
        }

        // We have a password -- continue with the save
        var userContext = UserContext()
        do {
            userContext = try req.content.decode(UserContext.self)
        } catch { throw UserControllerError.invalidForm }

        // Don't allow an attempt to add another root
        if userContext.name == "root" {
            throw UserControllerError.cantAddUpdateOrDeleteRoot
        }

        // Disallow duplicate usernames
        let user = try await UserModel.query(on: req.db)
            .filter(\.$name == userContext.name).first()
        guard user == nil else { throw UserControllerError.userNameAlreadyTaken }

        do {
            let userModel = UserModel(new: userContext)
            userModel.passwordHash = try Bcrypt.hash(userIdContextWithPassword.password)
            try await userModel.save(on: req.db)
            let res: Response = req.redirect(to: "/user/index")
            try res.content.encode(userModel.id, as: .json) // used for testing: see ControllerTests.swift
            return res
        } catch { throw UserControllerError.unableToCreateNewRecord }
    }

    /// Shows how to update a user; updating root is blocked.
    func update(req: Request) async throws -> Response {
        var userIdContextWithPassword = UserIdContextWithPassword()
        do {
            userIdContextWithPassword = try req.content.decode(UserIdContextWithPassword.self)
        } catch { throw UserControllerError.invalidForm }

        // Check the password, if one was given
        var password: String? = nil
        if userIdContextWithPassword.password != "" {
            password = userIdContextWithPassword.password
            guard userIdContextWithPassword.password == userIdContextWithPassword.confirmPassword else {
                throw UserControllerError.passwordsDontMatch
            }
        }

        // Get the context and the previous record to validate that one exists
        let userContext = try req.content.decode(UserContext.self)
        if userContext.name == "root" {
            throw UserControllerError.cantAddUpdateOrDeleteRoot
        }
        guard let userModel = try await UserModel.find(UUID(uuidString: userContext.id), on: req.db) else {
            throw UserControllerError.missingUser
        }

        // Update the model with the new values
       userModel.update(update: userContext)

        // If the password was entered, create a new hash
        if password != nil {
            userModel.passwordHash = try Bcrypt.hash(userIdContextWithPassword.password)
        }

        // save the updated user record and return to the 'show' page
        try await userModel.save(on: req.db)
        return req.redirect(to: "/user/show?id=\(userIdContextWithPassword.id)")
    }

    /// Shows how to delete a user; deleting root is blocked.
    func delete(req: Request) async throws -> Response {
        // This id comes from the POST content as opposed to GET parameters
        let userIdContext = try req.content.decode(UserIdContext.self)
        if let wrappedUser = try await UserModel.query(on: req.db)
            .filter(\.$id == UUID(uuidString: userIdContext.id)!).first() {
            if wrappedUser.name == "root" {
                throw UserControllerError.cantAddUpdateOrDeleteRoot
            }
            try await wrappedUser.delete(on: req.db)
            return req.redirect(to: "/user/index")
        } else {
            throw UserControllerError.missingUser
        }
    }
}
