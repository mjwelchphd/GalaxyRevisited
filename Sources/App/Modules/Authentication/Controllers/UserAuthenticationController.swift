///  File: Sources/App/Modules/Authentication/Controllers/AuthenticationController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor
import SwiftHtml

enum AuthenticationControllerErrors: Error {
    case unableToValidateSignIn
}

struct UserAuthenticationController: RouteCollection {
    /// Sets up the routes for AuthenticationController.
    func boot(routes: RoutesBuilder) throws {
        routes.get("sign-in", use: signIn)
        routes.get("sign-out", use: signOut)
        routes.post("log-in", use: logIn)    }

    /// Display the sign in page
    func signIn(req: Request) async throws -> Response {
        return req.templates.renderHtml(SignInTemplate())
    }

    /// Process the results of the sign-in page (i.e., authenticate)
    func logIn(req: Request) async throws -> Response {
        let credentials = try req.content.decode(Credentials.self)

        try await UserCredentialsAuthenticator().authenticate(credentials: credentials, for: req)

        print(req.auth.get(AuthenticatedUser.self)!)

        return req.redirect(to: "/")
    }

    /// Display the sign in page
    func signOut(req: Request) async throws -> Response {
        req.auth.logout(AuthenticatedUser.self)
        return req.redirect(to: "/")
    }
}
