///  File: Sources/App/Modules/Authentication/Controllers/AuthenticationController.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.
///
/// FILE: Sources/App/Modules/User/Authenticators/UserCredentialsAuthenticator.swift

import Vapor
import Fluent

// This name is built-in to Vapor, but this is the
// definition of Credentials everybody uses
struct Credentials: Content {
    let name: String
    let email: String
    let password: String
}

struct UserCredentialsAuthenticator: AsyncCredentialsAuthenticator {

    // The "credentials" arrive here from Vapor -- An attempt is made to find
    // the user, and if successful, validate the given password against the
    // passwordHash in the user record -- if unsuccessful, nothing is changed;
    // otherwise, the usermodel will be copied into an AuthenticatedUser DTO
    // and registered as the logged-in user
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
