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
                    Table {
                        Tr {
                            Td {
                                Label("User Name:").for("userName")
                            }
                            Td {
                                Input().type(.text).name("userName").value("")
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Password:").for("userPassword")
                            }
                            Td {
                                Input().type(.text).name("userPassword").value("")
                            }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Button("Sign In")
                                    .type(.submit)
                                    .name("sign-in")
                                    .formaction("/authenticate")
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
