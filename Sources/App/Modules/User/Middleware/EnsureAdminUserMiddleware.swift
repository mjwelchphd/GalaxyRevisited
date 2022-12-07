import Vapor

struct EnsureAdminUserMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard let user = request.auth.get(AuthenticatedUser.self), user.name == "root" || user.name == "admin" else {
            throw Abort(.unauthorized)
        }
        return try await next.respond(to: request)
    }
}
