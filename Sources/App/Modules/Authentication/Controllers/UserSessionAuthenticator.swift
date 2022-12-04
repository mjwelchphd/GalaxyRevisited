import Vapor
import Fluent

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    typealias User = AuthenticatedUser

    func authenticate(sessionID: User.SessionID, for req: Request) async throws {
        guard let user = try await UserModel.find(sessionID, on: req.db) else {
            return
        }
        req.auth.login(AuthenticatedUser(id: user.id!, name: user.name, email: user.email))
    }
}
