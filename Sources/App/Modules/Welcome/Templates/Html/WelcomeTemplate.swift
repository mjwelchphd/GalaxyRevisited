///  File: Sources/App/Modules/Welcome/Templates/Html/WelcomeTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct WelcomeTemplate: TemplateRepresentable {

    /// Template for the welcome page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Home")
            }
            Body {
                H1("Revisiting Galaxy")
                H3("Vapor's Fluent Demonstration Project")
                P("Your choices are:")
                Ul {
                    Li { A("Show the README").name("readme").href("http://localhost:8080/README.html") }
                    Li { A("List - list all galaxies").name("show").href("/galaxy/index") }
                    Li { A("Add - add a new galaxy").name("add").href("/galaxy/add") }
                }
                // Tag("Other text not encapsuled in HTML tag.")
                //  ^ use this to add text into the HTML without additional tags ^
                P(A("Create - restore the test galaxies and stars").name("create").href("/create-universes"))
            }
        }
        .lang("en-US")
    }
}
