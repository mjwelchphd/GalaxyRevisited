///  File: Sources/App/Modules/User/Middleware/EnsureAdminUserMiddleware.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

// Middleware to protect the UserController routes, but it can be applied to any routes
struct EnsureAdminUserMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        if request.isAdministrator() {
            return try await next.respond(to: request)
        } else {
            throw Abort(.unauthorized)
        }
    }
}
