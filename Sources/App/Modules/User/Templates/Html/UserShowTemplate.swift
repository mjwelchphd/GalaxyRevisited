///  File: Sources/App/Modules/User/Templates/Html/UserShowTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
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
                                Input().type(.text).name("passwordHash").value(userContext.passwordHash)
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
