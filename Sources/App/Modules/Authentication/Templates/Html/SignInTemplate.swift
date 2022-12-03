///  File: Sources/App/Modules/Welcome/Templates/Html/SignInTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 11/29/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct SignInTemplate: TemplateRepresentable {

    /// Template for the sign in page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Please sign in")
            }
            Body {
                H1("Please sign in")
                Form {
                    Input().type(.hidden).name("email").value("")
                    Table {
                        Tr {
                            Td {
                                Label("User Name:").for("name")
                            }
                            Td {
                                Input().type(.text).name("name").value("")
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("Password:").for("password")
                            }
                            Td {
                                Input().type(.password).name("password").value("")
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Button("Log In")
                                    .type(.submit)
                                    .name("log-in")
                                    .formaction("/log-in")
                                    .formmethod(.post)
                                    .formenctype(.urlencoded)
                            }
                        }
                    }
                }.name("sign-in-form")
                Br()
                A("Home").name("home").href("/")
            }
        }
        .lang("en-US")
    }
}
