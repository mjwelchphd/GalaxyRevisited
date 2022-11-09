///  File: Tests/AppTests/StarControllerTests.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 9/5/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

@testable import App

import XCTVapor

extension ControllerTests {

    func testStarController() async throws {

        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try await createUniverses(db: app.db)

        // Add a new galaxy to which we can next add a star
        // The reason to do this for testing
        let galaxyContext = GalaxyContext(
            id: "",
            name: "Small Magellanic Cloud (NGC 292)",
            magnitude: 2.7,
            distance: 200,
            constellation: "Tucana"
        )

        var smallMagenicCloudUuid: String = ""
        try app.test(.POST, "/galaxy/save",
            beforeRequest: { req in
                try req.content.encode(galaxyContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
                smallMagenicCloudUuid = try res.content.decode(String.self)
            }
        )

        // Both the StarIdContext and the StarContext are needed in order to add a star
        // but we can only encode one struct, so we create a struct just for testing
        struct StarTestingContext: Content {
            var starId: String = ""
            var galaxyId: String = ""
            var galaxyName: String = ""
            var name: String = ""
        }

        var starTestingContext = StarTestingContext(
            starId: "",
            galaxyId: smallMagenicCloudUuid,
            galaxyName: galaxyContext.name,
            name: "Nebula N81"
        )

        // Add the star, then we'll have the star's UUID for testing
        try app.test(.POST, "/star/save",
            beforeRequest: { req in
                try req.content.encode(starTestingContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
                // save the star UUID for update and delete tests
                starTestingContext.starId = try res.content.decode(String.self)
            }
        )

        let starIdContext = StarIdContext(starId: "", galaxyId: smallMagenicCloudUuid, galaxyName: "")
        let starIndexPageHtml = try retrievePageHtml(
            app: app,
            url: "/star/index",
            validationString: "<title>List All Stars</title>",
            context: starIdContext
        )

        try testButton(app, html: starIndexPageHtml,
                       formName: "show-form",
                       submitName: "show-submit",
                       hiddenInputs: ["galaxyId", "galaxyName", "starId"],
                       validationString: "<title>Show A Star</title>",
                       StarIdContext())


        // We could make a change, read back the star, and check it, but
        // we're not going to do that here -- here we just check the status
        try app.test(.POST, "/star/update",
            beforeRequest: { req in
                try req.content.encode(starTestingContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )

        // It's ok to delete without warning because the star was being
        // displayed when the user clicked the delete button -- nevertheless,
        // an "are you sure" page could be added before deleting
        // The starTestContext simulates a star context as read from the database
        try app.test(.POST, "/star/delete",
            beforeRequest: { req in
                try req.content.encode(starTestingContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )
    }
}
