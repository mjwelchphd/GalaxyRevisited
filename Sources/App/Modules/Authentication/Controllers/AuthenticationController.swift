///  File: Sources/App/Modules/Authentication/Controllers/AuthenticationController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor
import SwiftHtml

struct AuthenticationController: RouteCollection {
    /// Sets up the routes for AuthenticationController.
    func boot(routes: RoutesBuilder) throws {
        routes.get("sign-in", use: signIn)
        routes.post("authenticate", use: authenticate)
    }

    /// Display the sign in page
    func signIn(req: Request) async throws -> Response {
        return req.templates.renderHtml(SignInTemplate())
    }

    /// Display the sign in page
    func authenticate(req: Request) async throws -> Response {
        let signInContext = try req.content.decode(SignInContext.self)
        puts ("*300* \(signInContext)")
        return req.redirect(to: "/")
    }
}
