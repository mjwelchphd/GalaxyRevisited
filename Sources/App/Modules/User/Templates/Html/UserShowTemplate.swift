///  File: Sources/App/Modules/User/Templates/Html/UserShowTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct UserShowTemplate: TemplateRepresentable {
    var userContext: UserContext

    init(_ userContext: UserContext) {
        self.userContext = userContext
    }

    /// Template for the user show page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Show A User")
            }
            Body {
                H1("Show a User")

                Form {
                    Input().type(.hidden).name("id").value(userContext.id)
                    Input().type(.hidden).name("passwordHash").value(userContext.passwordHash)
                    Table {
                        Tr {
                            Td {
                                Label("Name:").for("name")
                            }
                            Td {
                                Input().type(.text).name("name").value(userContext.name)
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("email:").for("email")
                            }
                            Td {
                                Input().type(.text).name("email").value(userContext.email)
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("Password Hash:").for("passwordHash")
                            }
                            Td {
                                Tag(userContext.passwordHash)
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
                                Button("Update")
                                    .type(.submit)
                                    .name("update")
                                    .formaction("/user/update")
                                    .formmethod(.post)
                                Button("Delete")
                                    .type(.submit)
                                    .name("delete")
                                    .formaction("/user/delete")
                                    .formmethod(.post)
                            }
                        }
                    }
                }.name("show-user-form")
                Br()
                A("List All Users").name("user-index").href("/user/index")
                Br()
                A("Home").name("home").href("/")
            }
        }
        .lang("en-US")
    }
}
