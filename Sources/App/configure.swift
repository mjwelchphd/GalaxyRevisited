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

    // Set up session
    app.sessions.use(.fluent)
    app.sessions.configuration.cookieName = "galaxy"
    app.sessions.configuration.cookieFactory = { sessionID in
            .init(string: sessionID.string, isSecure: true)
    }
    app.middleware.use(app.sessions.middleware)

    // Register migrations
    app.migrations.add(SessionRecord.migration)
    app.migrations.add(CreateGalaxy())
    app.migrations.add(CreateStar())
    app.migrations.add(CreateUser())
    try app.autoMigrate().wait()

    app.middleware.use(UserSessionAuthenticator())
    
    // register routes
    try routes(app)
}
