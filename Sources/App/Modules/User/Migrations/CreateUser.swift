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
            .field("user_name", .string)
            .field("user_password", .string)
            .field("user_password_expires", .datetime)
            .field("temporary_password", .string)
            .field("temporary_password_expires", .datetime)
            .field("user_token", .string)
            .field("user_token_expires", .datetime)
            .create()
    }

    /// Moves the "users" table back to a previous migration; if fields are removed from
    /// the database in the process, that data will be lost from the database when the Vapor migrate command
    /// is run. Backing up the database beforehand would be a great idea. In Galaxy Revisited, revert is not
    /// used. One supposes it would only be used manually.
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
