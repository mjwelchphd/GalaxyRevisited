///  File: Tests/AppTests/ControllerTests.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

@testable import App

import XCTVapor
import SwiftHtml

/// ControllerTests is just a base to which other files will add the actual tests.
/// The controller tests are in separate files divided up by controller name and
/// added as extensions to ControllerTests make the code more manageable.
final class ControllerTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// The Regex "find" functions are added to "String" because it makes the code easier to read.
extension String {

    // This probably isn't the best way to do this, but it's necessary to remove
    // the new-line characters because the Regex.dotMatchesNewlines() fails with
    // "The bundle “AppTests” couldn’t be loaded. Try reinstalling the bundle."
    // While we're at it, might as well remove repetitions of spaces in order to
    // make messages in the log easier to read
    func cleanHtml() -> String {
        // Remove end-of-line and reduce multiple spaces down to 1 space
        var source = self.replacingOccurrences(of: "\n", with: " ")
        var count = source.count+1
        while source.count < count {
            count = source.count
            source = source.replacingOccurrences(of: "  ", with: " ")
        }
        return source
    }

    // Note the use of "firstMatch" -- when we retrieve an index page, we only want 1
    // link or button: we don't want to run the test for each record in the database
    func findRegex(searchFor: String) throws -> String? {
        let regex = try Regex(searchFor)
        let optionalMatch = self.firstMatch(of: regex)
        XCTAssertNotNil(optionalMatch, "No text \"\(searchFor)\" found in html \"\(self)\"")
        guard let match = optionalMatch else { return nil }
        XCTAssert(match.count == 2, "There should only be self plus 1 match for \"\(searchFor)\", duh!")
        guard match.count == 2 else { return nil }
        return String(describing: match[1].value!)
    }

    func findLink(name: String) throws -> String? {
        return try findRegex(searchFor: ".*(<a.+name=\"\(name)\".*?>.*?</a>).*")
    }

    func findHref() throws -> String? {
        return try findRegex(searchFor: #"href="(.*?)""#)
    }

    func findForm(name: String) throws -> String? {
        return try findRegex(searchFor: ".*(<form.+name=\"\(name)\".*?>.*?</form>).*")
    }

    func findHidden(name: String) throws -> String? {
        return try findRegex(searchFor: ".*(<input.+name=\"\(name)\".*?>).*")
    }

    func findValue() throws -> String? {
        return try findRegex(searchFor: #"value="(.*?)""#)
    }

    func findButton(name: String) throws -> String? {
        return try findRegex(searchFor: ".*(<button.+name=\"\(name)\".*?>).*")
    }

    func findFormaction() throws -> String? {
        return try findRegex(searchFor: #"formaction="(.*?)""#)
    }
}

extension ControllerTests {

    // Call the endpoint and validate that the returned HTML has the validation
    // string in it, often "<title>...</title>"
    func retrievePageHtml(app: Application, url: String, validationString: String) throws -> String {
        var html: String = ""
        try app.test(.GET, url,
            afterResponse: { res in
                XCTAssertTrue(res.status == .ok)
                guard res.status == .ok else { return }
                XCTAssertContains(res.body.string, validationString)
                html = res.body.string
            }
        )
        return html.cleanHtml()
    }

    func retrievePageHtml<C: Content>(app: Application, url: String,
                                      validationString: String, context: C) throws -> String {
        var html: String = ""
        try app.test(.GET, url,
            beforeRequest: { req in
                try req.query.encode(context)
            },
            afterResponse: { res in
                XCTAssertTrue(res.status == .ok)
                guard res.status == .ok else { return }
                XCTAssertContains(res.body.string, validationString)
                html = res.body.string
            }
        )
        return html.cleanHtml()
    }

    // Find the named link in the HTML and call the endpoint -- this like the user clicking on
    // the link in the page -- the retrieved page HTML is returned
    @discardableResult
    func testLink(_ app: Application, html: String, name: String, validationString: String) throws -> String {
        let optionalLink = try html.findLink(name: name)
        XCTAssertNotNil(optionalLink, "Testing name \"\(name)\" not found")
        guard let link = optionalLink else { return ""}

        let optionalHref = try link.findHref()
        guard let href = optionalHref else { return ""}
        return try retrievePageHtml(app: app, url: href, validationString: validationString)
    }

    // Find the named form-input(s)-button set in the HTML and call the endpoint -- this like
    // the user clicking on the button in the page -- the retrieved page HTML is returned
    @discardableResult
    func testButton<C: PairableContent>(_ app: Application,
                                        html: String,
                                        formName: String,
                                        submitName: String,
                                        hiddenInputs: [String],
                                        validationString: String,
                                        _: C) throws -> String {
        let optionalForm = try html.findForm(name: formName)
        XCTAssertNotNil(optionalForm, "Testing select \"\(formName)\" not found")
        guard let form = optionalForm else { return ""}

        var pairs: [String: String] = [:]
        for inputName in hiddenInputs {
            let inputForm = try form.findHidden(name: inputName)
            XCTAssertNotNil(inputForm, "Testing hidden \"\(inputName)\" not found")
            if inputForm != nil {
                if let value = try inputForm!.findValue() {
                    pairs[inputName] = value
                }
            }
        }

        // Create a context instance of type C and initialize with the value pairs
        let context = C(pairs: pairs)

        // The submit button contains the formaction (like href) to call
        let optionalSubmit = try form.findButton(name: submitName)
        XCTAssertNotNil(optionalSubmit, "Testing form \"\(form)\", submit button \(submitName) not found")
        guard let submit = optionalSubmit else { return ""}

        // The formaction is like href -- it has the endpoint address
        let formaction = try submit.findFormaction()

        // Call the endpoint by encoding context into req.query
        var html: String = ""
        try app.test(.GET, formaction!,
            beforeRequest: { req in
                try req.query.encode(context)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                XCTAssertContains(res.body.string, validationString)
                html = res.body.string
            if res.status != .ok { XCTAssert(false, "res.body.string -> \(res.body.string)") }
            }
        )
        return html.cleanHtml()
    }
}
