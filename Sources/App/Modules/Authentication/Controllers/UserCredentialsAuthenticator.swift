///  File: Sources/App/Modules/Authentication/Controllers/AuthenticationController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.
///
/// FILE: Sources/App/Modules/User/Authenticators/UserCredentialsAuthenticator.swift

import Vapor
import Fluent

struct Credentials: Content {
    let name: String
    let email: String
    let password: String
}

struct UserCredentialsAuthenticator: AsyncCredentialsAuthenticator {

    func authenticate(credentials: Credentials, for req: Request) async throws {
        guard
            let userModel = try await UserModel
                .query(on: req.db)
                .filter(\.$name == credentials.name)
                .first()
        else {
            return
        }
        do {
            guard try Bcrypt.verify(credentials.password, created: userModel.passwordHash) else {
                return
            }
            req.auth.login(AuthenticatedUser(model: userModel))
        }
        catch {
            // do nothing...
        }
    }
}
