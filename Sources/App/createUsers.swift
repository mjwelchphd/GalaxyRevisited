///  File: Sources/App/createUsers.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 5/23/23.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

/// Called from the startup page using the link, and before tests are run. Just 2 users are predefined. This method is used to provide instant test data.
func createUsers(db: Database) async throws {

    // Remove all existing records
    try await UserModel.query(on: db).delete()

    // Add users
    try await UserModel(name: "root", email: "root@example.com", passwordHash: "$2b$12$wnimPv.tsfdsSxL8LjjkPOWdMrobu7SaOc.s64OIRxDMgEKP5h87.", administrator: "Y").save(on: db)
    try await UserModel(name: "admin", email: "admin@example.com", passwordHash: "$2b$12$pSxGeR3H8TdJzjW1lafThenCizH9a/nfIf9UR7q9nTXnixOGlwW2G", administrator: "Y").save(on: db)
}
