///  File: Tests/AppTests/WelcomeControllerTests.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

@testable import App

import XCTVapor

extension ControllerTests {

    func testWelcomeController() async throws {

        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try await createUniverses(db: app.db)

        let welcomePageHtml =
        try retrievePageHtml(
            app: app,
            url: "/",
            validationString: "<title>Home</title>"
        )

        try testLink(
            app,
            html: welcomePageHtml,
            name: "show",
            validationString: "<title>List All Galaxies</title>"
        )

        try testLink(
            app,
            html: welcomePageHtml,
            name: "add",
            validationString: "<title>Add A New Galaxy</title>"
        )

        try app.test(.GET, "",
            afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                XCTAssertContains(res.body.string, "Revisiting Galaxy")
            }
        )
    }
}
