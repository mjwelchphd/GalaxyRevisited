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
        try await UserModel(name: "root", email: "root@example.com", passwordHash: "<no hash>").save(on: database)
    }

    /// Moves the "users" table back to a previous migration; if fields are removed from
    /// the database in the process, that data will be lost from the database when the Vapor migrate command
    /// is run. Backing up the database beforehand would be a great idea. In Galaxy Revisited, revert is not
    /// used. One supposes it would only be used manually.
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
