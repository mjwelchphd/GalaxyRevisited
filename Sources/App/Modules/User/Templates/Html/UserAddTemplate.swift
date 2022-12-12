///  File: Sources/App/Modules/User/Templates/Html/UserAddTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml
import Foundation

struct UserAddTemplate: TemplateRepresentable {

    /// Template for the user add page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Add A User")
            }
            Body {
                H1("Add a New User")
                Form {
                    Input().type(.hidden).name("id").value("")
                    Input().type(.hidden).name("passwordHash").value("")
                    Input().type(.hidden).name("administrator").value("N")
                    Table {
                        Tr {
                            Td {
                                Label("Name:").for("name")
                            }
                            Td {
                                Input().type(.text).name("name").value("")
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("EMail:").for("email")
                            }
                            Td {
                                Input().type(.text).name("email").value("")
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
                                Label("Confirm Password:").for("confirmPassword")
                            }
                            Td {
                                Input().type(.password).name("confirmPassword").value("")
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Button("Save")
                                    .type(.submit)
                                    .name("save")
                                    .formaction("/user/save")
                                    .formmethod(.post)
                                    .formenctype(.urlencoded)
                            }
                        }
                    }
                }.name("add-user-form")
                Br()
                A("List all users").name("list-all-users").href("/user/index")
                Br()
                A("Home").name("home").href("/")
            }
        }
        .lang("en-US")
    }
}
