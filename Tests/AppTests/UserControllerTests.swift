///  File: Tests/AppTests/UserControllerTests.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 11/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

@testable import App

import XCTVapor

extension ControllerTests {

    func testUserController() async throws {

/*        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try await createUniverses(db: app.db)

        let userIndexPageHtml =
        try retrievePageHtml(
            app: app,
            url: "/user/index",
            validationString: "<title>List All Users</title>"
        )

        try testButton(
            app,
            html: userIndexPageHtml,
            formName: "show-form",
            submitName: "show-submit",
            hiddenInputs: ["userId"],
            validationString: "<title>Show A User</title>",
            UserIdContext()
        )

        try testLink(
            app,
            html: userIndexPageHtml,
            name: "home",
            validationString: "<title>Home</title>"
        )

        //=== data item for testing=======================================================
        var noNameUuid: String = ""
        var userContext = UserContext(
            id: "",
            name: "NoName",
            email: "noname@example.com",
            passwordHash: ""
        )
        //================================================================================

        try app.test(.POST, "/user/save",
            beforeRequest: { req in
            userContext.userId = ""
                userContext.userId = ""
                try req.content.encode(userDecodeContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
                noNameUuid = try res.content.decode(String.self)
            }
        )

        try app.test(.POST, "/user/update",
            beforeRequest: { req in
                userContext.userId = noNameUuid
                let userDecodeContext = UserContextUsingStringsForDates(encoded: userContext)
                try req.content.encode(userDecodeContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )

        try app.test(.POST, "/user/delete",
            beforeRequest: { req in
                var userIdContext = UserIdContext()
                userIdContext.userId = noNameUuid
                try req.content.encode(userIdContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )*/
    }
}
