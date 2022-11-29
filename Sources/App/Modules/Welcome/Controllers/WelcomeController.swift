///  File: Sources/App/Modules/Welcome/Controllers/WelcomeController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor
import SwiftHtml

struct WelcomeController: RouteCollection {
    /// Sets up the routes for WelcomeController.
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
        routes.get("create-universes", use: create)
        routes.get("sign-in", use: signIn)
    }

    /// Display the welcome (home) page.
    func index(req: Request) async throws -> Response {
        return req.templates.renderHtml(WelcomeTemplate())
    }

    /// Display the sign in page
    func signIn(req: Request) async throws -> Response {
        return req.templates.renderHtml(SignInTemplate())
    }

    /// (Re)create the test data in the database.
    func create(req: Request) async throws -> Response {
        try await createUniverses(db: req.db)
        return req.redirect(to: "/galaxy/index")
    }
}
