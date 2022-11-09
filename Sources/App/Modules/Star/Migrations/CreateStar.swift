///  File: Sources/App/Modules/Star/Migrations/CreateStar.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent

struct CreateStar: AsyncMigration {

    /// Creates the "stars" table in the database when the Vapor migrate command
    /// is run. In Galaxy Revisited, the migration is automatic and does not need to be run manually.
    func prepare(on database: Database) async throws {
        try await database.schema("stars")
            .id()
            .field("name", .string)
            .field("galaxyId", .uuid, .references("galaxies", "id"))
            .create()
    }

    /// Moves the "stars" table back to a previous migration; if fields are removed from
    /// the database in the process, that data will be lost from the database when the Vapor migrate command
    /// is run. Backing up the database beforehand would be a great idea. In Galaxy Revisited, revert is not
    /// used. One supposes it would only be used manually.
    func revert(on database: Database) async throws {
        try await database.schema("stars").delete()
    }
}
