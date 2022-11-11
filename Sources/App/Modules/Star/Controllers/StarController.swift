///  File: Sources/App/Modules/Star/Controllers/StarController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import FluentKit
import Vapor

enum StarControllerError: Error {
    case idParameterMissing
    case idParameterInvalid
    case missingGalaxy
    case missingStar
    case unableToCreateNewRecord
}

/// StarController contains the endpoint functions for "/star/..." URLs.
struct StarController: RouteCollection {

    /// Endpoints map for the GalaxyController.
    func boot(routes: RoutesBuilder) throws {
        let starRoutes = routes.grouped("star")
        starRoutes.get("index", use: index)

        // The requests -- the show1 and show2 demonstrate 2 ways to pass the 'galaxyId' parameter
        starRoutes.get("add", use: add)
        starRoutes.post("save", use: save)
        starRoutes.get("show", use: show)
        starRoutes.post("update", use: update)
        starRoutes.post("delete", use: delete)
    }

    /// Pull up a list of a galaxy, it's stars, and their UUIDs needed to link to other endpoints.
    func index(req: Request) async throws -> Response {
        let starIdContext = try req.query.decode(StarIdContext.self)

        // Get the galaxy and stars together using "eager load"
        let galaxyId = UUID(starIdContext.galaxyId)!
        let wrappedGalaxy = try await GalaxyModel.query(on: req.db).with(\.$stars).filter(\.$id == galaxyId).first()

        // Be sure the galaxy exists -- only linked stars will be found, so no guard needed for that
        guard let galaxy = wrappedGalaxy else {
            throw StarControllerError.missingGalaxy
        }

        // Last, put the galaxy and star rows from the query into a StarsContext
        let starsContext = StarsContext(many: galaxy.stars, parent: galaxy)
        return req.templates.renderHtml(StarIndexTemplate(starsContext))
    }

    /// Demonstrates how to pass the_galaxyId, _galaxyName_, and the _starId_  as parameters of the URL.
    func show(req: Request) async throws -> Response {
        // First, get the 'id' parameter (for the star)
        // If 'galaxyId' and 'starId' aren't in the query,
        // decode will throw an error "Value of type 'String' required for key 'id'."
        var starIdContext: StarIdContext
        do {
            starIdContext = try req.query.decode(StarIdContext.self)
        } catch { throw StarControllerError.idParameterMissing }
        guard let starId = UUID(uuidString: starIdContext.starId) else {
            throw StarControllerError.idParameterInvalid
        }
        guard let star = try await StarModel.find(starId, on: req.db) else {
            throw StarControllerError.missingStar
        }
        return req.templates.renderHtml(StarShowTemplate(StarContext(model: star), starIdContext))
    }

    /// Shows how to present an HTML template to enter a new star.
    func add(req: Request) async throws -> Response {
        let starIdContext = try req.query.decode(StarIdContext.self)
        let html = req.templates.renderHtml(StarAddTemplate(starIdContext))
        return html
    }

    /// Shows how to save the new star from the "add" page.
    func save(req: Request) async throws -> Response {
        var starIdContext: StarIdContext
        do {
            starIdContext = try req.content.decode(StarIdContext.self)
        } catch { throw StarControllerError.idParameterMissing }

        // The context scope needs to be outside the 'do'
        var starContext: StarContext
        do {
            starContext = try req.content.decode(StarContext.self)
        } catch { throw StarControllerError.idParameterMissing }

        do {
            let starModel = StarModel(new: starContext, galaxyId: UUID(starIdContext.galaxyId)!)
            try await starModel.save(on: req.db)
            let res = req.redirect(to: "/star/index?galaxyId=\(starIdContext.galaxyId)&galaxyName=&starId=")
            try res.content.encode(starModel.id, as: .json) // used for testing: see ControllerTests.swift
            return res
        } catch { throw GalaxyControllerError.unableToCreateNewRecord }
    }

    /// Shows how to retrieve a star that was previously read from the database and displayed to the user.
    func update(req: Request) async throws -> Response {
        let starContext = try req.content.decode(StarContext.self)
        guard let starModel = try await StarModel.find(UUID(uuidString: starContext.starId)!, on: req.db) else {
            throw StarControllerError.missingGalaxy
        }
        let galaxyId = starModel.$galaxy.id.uuidString // pick it up here because it gets lost after starModel.save
        starModel.update(update: starContext)
        try await starModel.save(on: req.db)
        return req.redirect(to: "/star/index?galaxyId=\(galaxyId)&galaxyName=&starId=")
    }

    /// Shows how to delete a star
    func delete(req: Request) async throws -> Response {
        let starContext = try req.content.decode(StarContext.self)
        guard let starModel = try await StarModel.find(UUID(uuidString: starContext.starId)!, on: req.db) else {
            throw StarControllerError.missingGalaxy
        }
        let galaxyId = starModel.$galaxy.id.uuidString // pick it up here because it gets lost after starModel.save
        starModel.update(update: starContext)
        try await starModel.delete(on: req.db)
        return req.redirect(to: "/star/index?galaxyId=\(galaxyId)&galaxyName=&starId=")
    }
}
