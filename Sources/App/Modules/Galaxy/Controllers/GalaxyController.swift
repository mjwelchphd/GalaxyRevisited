///  File: Sources/App/Modules/Galaxy/Controllers/GalaxyController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor

enum GalaxyControllerError: Error {
    case idParameterMissing
    case idParameterInvalid
    case missingGalaxy
    case invalidForm
    case unableToCreateNewRecord
}

/// GalaxyController contains the endpoint functions for "/galaxy/..." URLs.
struct GalaxyController: RouteCollection {

    /// Endpoints map for the GalaxyController.
    func boot(routes: RoutesBuilder) throws {
        let galaxyRoutes = routes.grouped("galaxy")
        galaxyRoutes.get("index", use: index)               // maps: "/galaxy/index"

        // The requests -- the show1 and show2 demonstrate 2 ways to pass the 'galaxyId' parameter
        galaxyRoutes.get("add", use: add)                   // maps: "/galaxy/add"
        galaxyRoutes.post("save", use: save)                // maps: "/galaxy/save"
        galaxyRoutes.get("show1", ":galaxyId", use: show1)  // maps: "/galaxy/show/<galaxyId>"
        galaxyRoutes.get("show2", use: show2)               // maps: "/galaxy/show?galaxyId=<galaxyId>"
        galaxyRoutes.post("update", use: update)            // maps: "/galaxy/update"
        galaxyRoutes.post("delete", use: delete)            // maps: "/galaxy/delete"
    }

    /// Pull up a list of all the galaxies, and importantly, their UUIDs needed to link to other endpoints.
    func index(req: Request) async throws -> Response {
        let galaxiesContext = GalaxiesContext(many: try await GalaxyModel.query(on: req.db).all())
        return req.templates.renderHtml(GalaxyIndexTemplate(galaxiesContext))
    }

    /// Demonstrates how to pass the galaxy UUID  as part of the URL.
    func show1(req: Request) async throws -> Response {
        guard let galaxyId = req.parameters.get("galaxyId") else {
            throw GalaxyControllerError.idParameterMissing
        }
        return try await showGalaxy(req, galaxyId)
    }

    /// Demonstrates how to pass the galaxy UUID  as a parameter of the URL and displays as a link (_Show-2_).
    /// Demonstrates how to pass the galaxy UUID  as a parameter of the URL, and displays as a button (_Show-3_).
    func show2(req: Request) async throws -> Response {
        guard let galaxyIdContext = try? req.query.decode(GalaxyIdContext.self) else {
            throw GalaxyControllerError.idParameterMissing
        }
        return try await showGalaxy(req, galaxyIdContext.galaxyId)
    }

    /// Demonstrates how to complete a _Show_ request.
    func showGalaxy(_ req: Request, _ galaxyId: String) async throws -> Response {
        guard let galaxyId = UUID(uuidString: galaxyId) else {
            throw GalaxyControllerError.idParameterInvalid
        }
        guard let galaxy = try await GalaxyModel.find(galaxyId, on: req.db) else {
            throw GalaxyControllerError.missingGalaxy
        }
        return req.templates.renderHtml(GalaxyShowTemplate(GalaxyContext(model: galaxy)))
    }

    /// Shows how to present an HTML template to enter a new galaxy.
    func add(req: Request) -> Response {
        return req.templates.renderHtml(GalaxyAddTemplate())
    }

    /// Shows how to retrieve the new galaxy from the "add" page.
    ///
    /// The new galaxy comes encoded into the body of the request.
    /// Use content.decode to get the new galaxy from the request body.
    /// GalaxyModel(new:) will set the "galaxyId" to nil which will signal Fluent that this is a new record.
    func save(req: Request) async throws -> Response {
        var galaxyContext = GalaxyContext()
        do {
            galaxyContext = try req.content.decode(GalaxyContext.self)
        } catch { throw GalaxyControllerError.invalidForm }
        do {
            let galaxyModel = GalaxyModel(new: galaxyContext)
            try await galaxyModel.save(on: req.db)
            let res: Response = req.redirect(to: "/galaxy/index")
            try res.content.encode(galaxyModel.id, as: .json) // used for testing: see ControllerTests.swift
            return res
        } catch { throw GalaxyControllerError.unableToCreateNewRecord }
    }

    /// Shows how to retrieve a galaxy that was previously read from the database and displayed
    /// to the user. The updated record comes encoded into the body of the request. The galaxy whose UUID is
    /// in the decoded galaxyContext is used to find the record in the database. The galaxyModel.update(update:)
    /// then copies the fields from the decoded record into the model. The "galaxyId" is already populated, so
    /// Fluent will update the existing record as opposed to creating a new one.
    func update(req: Request) async throws -> Response {
        let galaxyContext = try req.content.decode(GalaxyContext.self)
        guard let galaxyModel = try await GalaxyModel.find(UUID(uuidString: galaxyContext.galaxyId), on: req.db) else {
            throw GalaxyControllerError.missingGalaxy
        }
        galaxyModel.update(update: galaxyContext)
        try await galaxyModel.save(on: req.db)
        return req.redirect(to: "/galaxy/index")
    }

    /// Shows how to delete a galaxy, but more importantly, a galaxy may have children (stars),
    /// and the stars (if any) have to be deleted first. This also shows the use of the Fluent filter method.
    func delete(req: Request) async throws -> Response {
        // This id comes from the POST content as opposed to GET parameters
        let galaxyIdContext = try req.content.decode(GalaxyIdContext.self)

        // Get the galaxy for which the stars will be looked up and eager load the stars
        if let wrappedGalaxy = try await GalaxyModel.query(on: req.db).with(\.$stars)
            .filter(\.$id == UUID(uuidString: galaxyIdContext.galaxyId)!).first() {
            for star in wrappedGalaxy.stars {
                //  Delete all the stars first or the galaxy delete will fail
                try await star.delete(on: req.db)
            }

            // The stars have all supernova-ed; now the galaxy can go
            try await wrappedGalaxy.delete(on: req.db)
            return req.redirect(to: "/galaxy/index")
        } else {
            throw GalaxyControllerError.missingGalaxy
        }
    }
}
