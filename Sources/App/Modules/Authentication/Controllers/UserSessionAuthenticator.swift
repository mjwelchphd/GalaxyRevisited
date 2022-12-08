///  File: Sources/App/Modules/Authentication/Controllers/UserSessionAuthenticator.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent
import Foundation

struct UserSessionAuthenticator: AsyncSessionAuthenticator {
    typealias User = AuthenticatedUser

    // If a user is logged in, the UUID of the userModel will be passed in as "sessionID",
    // but while it does come from the session, it's NOT the "id" of the _fluent_sessions
    // table in the database. It comes from _fluent_sessions.data; see the table example below:
    // mysql> select * from _fluent_sessions;
    // +---------------------+--------------------------+------------------------------------------------------+
    // | id                  | key                      | data                                                 |
    // +---------------------+--------------------------+------------------------------------------------------+
    // | 0x2ED636606FA04A... | 4O/KQT2RS5FfCP0NvJMR7... | {"_AuthenticatedUserSession": "D4F618BF-8610-4E..."} |
    // +---------------------+--------------------------+------------------------------------------------------+
    // The type "User.SessionID" is defined in AuthenticatedUserContext.swift and is a UUID in GalaxyRevisited
    // If no user is logged in, the "sessionID" will be nil, the find will fail, and the guard will return
    // without generating an error; otherwise, the usermodel will be copied into an AuthenticatedUser DTO
    // and registered as the logged-in user
    func authenticate(sessionID: User.SessionID, for req: Request) async throws {
        guard let userModel = try await UserModel.find(sessionID, on: req.db) else {
            return
        }
        req.auth.login(AuthenticatedUser(model: userModel))
    }
}
