import Vapor
import Fluent
import Foundation

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    typealias User = AuthenticatedUser

    // The sessionID is the User.id (UUID)
    func authenticate(sessionID: User.SessionID, for req: Request) async throws {
        guard let userModel = try await UserModel.find(sessionID, on: req.db) else {
            return
        }
        req.auth.login(AuthenticatedUser(model: userModel))
    }
}
