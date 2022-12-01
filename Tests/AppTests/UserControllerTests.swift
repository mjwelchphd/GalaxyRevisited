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

        //=== data items for testing======================================================
        var noNameUuid: String = ""
        var userContext = UserContext(
            id: "",
            name: "NoName",
            email: "noname@example.com",
            passwordHash: "$2b$12$XLs7ads0oQCrs.HbT3S9gOwSrsABXRqbdGCWju9z52qF85G47fS3S" // "trash"
        )

//        var userIdContextWithPassword =  UserIdContextWithPassword(
//            id: "",
//            password: "trash",
//            confirmPassword: "trash"
//        )

        struct UserSendContext: Content {
            var id: String
            var name: String
            var email: String
            var passwordHash: String
            var password: String
            var confirmPassword: String

            init() {
                id = ""
                name = "NoName"
                email = "noname@example.com"
                passwordHash = "$2b$12$XLs7ads0oQCrs.HbT3S9gOwSrsABXRqbdGCWju9z52qF85G47fS3S"
                password = "trash"
                confirmPassword = "trash"
            }
        }
        var userSendContext = UserSendContext()
        //================================================================================

        try app.test(.POST, "/user/save",
            beforeRequest: { req in
                userSendContext.id = "" // save
                try req.content.encode(userSendContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
                noNameUuid = try res.content.decode(String.self)
            }
        )

        try app.test(.POST, "/user/update",
            beforeRequest: { req in
                userSendContext.id = noNameUuid // update
                try req.content.encode(userContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )

        try app.test(.POST, "/user/delete",
            beforeRequest: { req in
                var userIdContext = UserIdContext()
                userIdContext.id = noNameUuid
                try req.content.encode(userIdContext, as: .urlEncodedForm)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        )*/
    }
}
