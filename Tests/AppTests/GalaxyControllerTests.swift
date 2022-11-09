///  File: Tests/AppTests/GalaxyControllerTests.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

@testable import App

import XCTVapor

extension ControllerTests {

    func testGalaxyController() async throws {

        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try await createUniverses(db: app.db)

        let galaxyIndexPageHtml =
        try retrievePageHtml(
            app: app,
            url: "/galaxy/index",
            validationString: "<title>List All Galaxies</title>"
        )

        try testLink(
            app,
            html: galaxyIndexPageHtml,
            name: "show-1-link",
            validationString: "<title>Show A Galaxy</title>"
        )

        try testLink(
            app,
            html: galaxyIndexPageHtml,
            name: "show-2-link",
            validationString: "<title>Show A Galaxy</title>"
        )

        try testButton(
            app,
            html: galaxyIndexPageHtml,
            formName: "show-3-form",
            submitName: "show-3-submit",
            hiddenInputs: ["galaxyId"],
            validationString: "<title>Show A Galaxy</title>",
            GalaxyIdContext()
        )

        try testButton(
            app,
            html: galaxyIndexPageHtml,
            formName: "show-stars-form",
            submitName: "show-stars-submit",
            hiddenInputs: ["galaxyId", "galaxyName", "starId"],
            validationString: "<title>List All Stars</title>", StarIdContext()
        )

        try testLink(
            app,
            html: galaxyIndexPageHtml,
            name: "home",
            validationString: "<title>Home</title>"
        )

        var smallMagenicCloudUuid: String = ""
        var galaxyContext = GalaxyContext(
            id: "",
            name: "Small Magellanic Cloud (NGC 292)",
            magnitude: 2.7,
            distance: 200,
            constellation: "Tucana"
        )

        try app.test(.POST, "/galaxy/save",
            beforeRequest: { req in
                try req.content.encode(galaxyContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
                smallMagenicCloudUuid = try res.content.decode(String.self)
            }
        )

        try app.test(.POST, "/galaxy/update",
            beforeRequest: { req in
                galaxyContext.galaxyId = smallMagenicCloudUuid
                try req.content.encode(galaxyContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )

        try app.test(.POST, "/galaxy/delete",
            beforeRequest: { req in
                var galaxyIdContext = GalaxyIdContext()
                galaxyIdContext.galaxyId = smallMagenicCloudUuid
                try req.content.encode(galaxyIdContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )
    }
}
