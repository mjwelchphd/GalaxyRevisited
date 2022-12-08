///  File: Sources/App/Modules/Authentication/Controllers/AuthenticationController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
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
        routes.post("log-in", use: signInAction)    }

    /// Display the sign in page.
    func signIn(req: Request) async throws -> Response {
        return req.templates.renderHtml(SignInTemplate(SignInContext(name: "")))
    }

    // Note that there are two "authenticate" methods, one in UserCredentialsAuthenticator.swift,
    // and another in UserSessionAuthenticator.swift -- only the former is called here;
    // the latter is called by middleware to restore the logged on user from the
    // session record (_fluent_sessions.data)
    /// Process the results of the sign-in page (i.e., authenticate the user, if possible).
    func signInAction(req: Request) async throws -> Response {
        // The previous user must be logged out because the only way to know
        // if the new user was successfully logged in is to check req.auth.get --
        // The session MUST NOT be destroyed here or the current login
        // will be lost with it
        req.auth.logout(AuthenticatedUser.self)

        // We have to get the credentials here in case we need the name for the error message
        let credentials = try req.content.decode(Credentials.self)

        // We call the Vapor authenticate(request: Request) and it decodes the credentials
        // then calls our UserAuthenticationController.authenticate(credentials: Credentials)
        try await UserCredentialsAuthenticator().authenticate(credentials: credentials, for: req)
        if let user = req.auth.get(AuthenticatedUser.self) {
            print("User \(user) logged in.")
            return req.redirect(to: "/")
        } else {
            req.session.destroy()
        }
        let signInContext = SignInContext(name: credentials.name, error: "Unable to find the user name and password combination.")
        return req.templates.renderHtml(SignInTemplate(signInContext))
    }

    // Note that "req.session.unauthenticate" only removes the authentication part of the session data;
    // if another user gets logged in, that user inherits the previous users data -- The method
    // "req.session.destroy" completely removes all session data, deletes the session record in
    // the "_fluent_sessions" table, creates a new session with a new cookie, and updates
    // the cookie in the browser -- that's why we use "destroy" rather than "unauthenticate"
    // NOTE: you MUST return with a response or redirect, or "req.session.destroy" will not complete.
    /// Close out the current user and session and throw away the session data.
    func signOut(req: Request) async throws -> Response {
        req.auth.logout(AuthenticatedUser.self)
        req.session.destroy()
        return req.redirect(to: "/")
    }
}
