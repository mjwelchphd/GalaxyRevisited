///  File: Sources/App/Modules/Welcome/Templates/Html/WelcomeTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent
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

                if let authenticatedUser = req.auth.get(AuthenticatedUser.self) {
                    P("Welcome \(authenticatedUser.name)")
                }

                P("Your choices are:")
                Ul {
                    Li { A("Show the README").name("readme").href("README.html") }
                    Li { A("List - list all galaxies").name("show").href("/galaxy/index") }
                    Li { A("Add - add a new galaxy").name("add").href("/galaxy/add") }
                    Li { A("Create - restore the test galaxies and stars").name("create").href("/create-universes") }
                }

                // Tag("Other text not encapsuled in HTML tag.")
                //  ^ use this to add text into the HTML without additional tags ^

                P("Your admin testing choices are:")
                Ul {

                    if let authenticatedUser = req.auth.get(AuthenticatedUser.self) {
                        if authenticatedUser.administrator == "Y" {
                            Li { A("List All Users").name("list-all-users").href("/user/index") }
                        }
                    }

                    Li { A("Sign In").name("sign-in").href("/sign-in") }
                    Li { A("Sign Out").name("sign-out").href("/sign-out") }
                }
            }
        }
        .lang("en-US")
    }
}
