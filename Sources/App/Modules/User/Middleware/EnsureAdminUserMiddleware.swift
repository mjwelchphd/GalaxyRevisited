///  File: Sources/App/Modules/User/Middleware/EnsureAdminUserMiddleware.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

struct EnsureAdminUserMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard let user = request.auth.get(AuthenticatedUser.self), user.name == "root" || user.name == "admin" else {
            throw Abort(.unauthorized)
        }
        return try await next.respond(to: request)
    }
}
