///  File: Sources/App/configure.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent
//import FluentSQLiteDriver
import FluentMySQLDriver

/// Called at the start up of the Vapor app.
public func configure(_ app: Application) throws {

    // Serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // app.databases.use(.sqlite(.file("Resources/galaxy.sqlite")), as: .sqlite)

    var tls = TLSConfiguration.makeClientConfiguration()
    tls.certificateVerification = .none
    app.databases.use(
        .mysql(
            hostname: "localhost",
            username: "coco",
            password: "Milky-1-Way",
            database: "galaxies",
            tlsConfiguration: tls
        ),
        as: .mysql
    )

    // Register migrations, except for sessions
    app.migrations.add(CreateGalaxy())
    app.migrations.add(CreateStar())
    app.migrations.add(CreateUser())

    // Set up session, including session migration -- these calls must
    // be made in this order or the app will produce strange results
    app.sessions.use(.fluent)
    app.sessions.configuration.cookieName = "galaxy"
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)
    app.middleware.use(UserSessionAuthenticator())

    // Continue with the migration (if any)
    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
