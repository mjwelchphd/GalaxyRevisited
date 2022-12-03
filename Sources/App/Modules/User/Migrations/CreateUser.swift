///  File: Sources/App/Modules/User/Migrations/CreateUser.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent

struct CreateUser: AsyncMigration {

    /// Creates the "users" table in the database when the Vapor migrate command
    /// is run. In Galaxy Revisited, the migration is automatic and does not need to be run manually.
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string)
            .field("email", .string)
            .field("password_hash", .string)
            .create()
        // The password for root is "secret", and it's hash is below
        try await UserModel(name: "root", email: "root@example.com", passwordHash: "$2b$12$wnimPv.tsfdsSxL8LjjkPOWdMrobu7SaOc.s64OIRxDMgEKP5h87.").save(on: database)
    }

    /// Moves the "users" table back to a previous migration.
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
