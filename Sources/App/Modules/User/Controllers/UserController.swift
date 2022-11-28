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
}

/// UserController contains the endpoint functions for "/user/..." URLs.
struct UserController: RouteCollection {

    /// Endpoints map for the UserController.
    func boot(routes: RoutesBuilder) throws {
        let userRoutes = routes.grouped("user")
        userRoutes.get("index", use: index)               // maps: "/user/index"

        // The requests -- the show1 and show2 demonstrate 2 ways to pass the 'userId' parameter
        userRoutes.get("add", use: add)                   // maps: "/user/add"
        userRoutes.post("save", use: save)                // maps: "/user/save"
        userRoutes.get("show", use: show)                 // maps: "/user/show?userId=<userId>"
        userRoutes.post("update", use: update)            // maps: "/user/update"
        userRoutes.post("delete", use: delete)            // maps: "/user/delete"
    }

    /// Pull up a list of all the users, and importantly, their UUIDs needed to link to other endpoints.
    func index(req: Request) async throws -> Response {
        let usersContext = UsersContext(many: try await UserModel.query(on: req.db).all())
        return req.templates.renderHtml(UserIndexTemplate(usersContext))
    }

    /// Demonstrates how to pass the user UUID  as a parameter of the URL and displays as a link (_Show-2_).
    /// Demonstrates how to pass the user UUID  as a parameter of the URL, and displays as a button (_Show-3_).
    func show(req: Request) async throws -> Response {
        guard let userIdContext = try? req.query.decode(UserIdContext.self) else {
            throw UserControllerError.idParameterMissing
        }
        guard let userId = UUID(uuidString: userIdContext.userId) else {
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
    ///
    /// The new user comes encoded into the body of the request.
    /// Use content.decode to get the new user from the request body.
    /// UserModel(new:) will set the "userId" to nil which will signal Fluent that this is a new record.
    func save(req: Request) async throws -> Response {
        var userContext = UserContext()
        do {
            let userDecodeContext1 = try req.content.decode(UserContextUsingStringsForDates.self)
            userContext = UserContext(decoded: userDecodeContext1)
        } catch { throw UserControllerError.invalidForm }
        do {
            let userModel = UserModel(new: userContext)
            try await userModel.save(on: req.db)
            let res: Response = req.redirect(to: "/user/index")
            try res.content.encode(userModel.id, as: .json) // used for testing: see ControllerTests.swift
            return res
        } catch { throw UserControllerError.unableToCreateNewRecord }
    }

    /// Shows how to retrieve a user that was previously read from the database and displayed
    /// to the user. The updated record comes encoded into the body of the request. The user whose UUID is
    /// in the decoded userContext is used to find the record in the database. The userModel.update(update:)
    /// then copies the fields from the decoded record into the model. The "userId" is already populated, so
    /// Fluent will update the existing record as opposed to creating a new one.
    func update(req: Request) async throws -> Response {
        let userDecodeContext = try req.content.decode(UserContextUsingStringsForDates.self)
        let userContext = UserContext(decoded: userDecodeContext)
        guard let userModel = try await UserModel.find(UUID(uuidString: userContext.userId), on: req.db) else {
            throw UserControllerError.missingUser
        }
        userModel.update(update: userContext)
        try await userModel.save(on: req.db)
        return req.redirect(to: "/user/index")
    }

    /// Shows how to delete a user, but more importantly, a user may have children (stars),
    /// and the stars (if any) have to be deleted first. This also shows the use of the Fluent filter method.
    func delete(req: Request) async throws -> Response {
        // This id comes from the POST content as opposed to GET parameters
        let userIdContext = try req.content.decode(UserIdContext.self)

        // Get the user for which the stars will be looked up and eager load the stars
        if let wrappedUser = try await UserModel.query(on: req.db)
            .filter(\.$id == UUID(uuidString: userIdContext.userId)!).first() {
            try await wrappedUser.delete(on: req.db)
            return req.redirect(to: "/user/index")
        } else {
            throw UserControllerError.missingUser
        }
    }
}
