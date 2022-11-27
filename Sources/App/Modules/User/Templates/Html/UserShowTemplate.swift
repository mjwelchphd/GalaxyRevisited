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
                    Input().type(.hidden).name("userId").value(userContext.userId)
                    Input().type(.hidden).name("userToken").value(userContext.userToken)
                    Table {
                        Tr {
                            Td {
                                Label("User ID:")
                            }
                            Td {
                                Input().type(.text).name("showUserId").value(userContext.userId).size(36).disabled()
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Name:").for("userName")
                            }
                            Td {
                                Input().type(.text).name("userName").value(userContext.userName)
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Password:").for("userPassword")
                            }
                            Td {
                                Input().type(.text).name("userPassword").value(userContext.userPassword)
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Password Expires:").for("userPasswordExpires")
                            }
                            Td {
                                Input().type(.text).name("userPasswordExpires").value(userContext.userPasswordExpires.toString(format: "MM/dd/yyyy"))
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("Temporary Password:").for("temporaryPassword")
                            }
                            Td {
                                Input().type(.text).name("temporaryPassword").value(userContext.temporaryPassword)
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("Temporary Password Expires:").for("temporaryPasswordExpires")
                            }
                            Td {
                                Input().type(.text).name("temporaryPasswordExpires").value(userContext.temporaryPasswordExpires.toString(format: "MM/dd/yyyy"))
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Token:").for("userToken")
                            }
                            Td {
                                Input().type(.text).name("userToken").value(userContext.userToken).size(34).disabled()
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Token Expires:").for("userTokenExpires")
                            }
                            Td {
                                Input().type(.text).name("userTokenExpires").value(userContext.userTokenExpires.toString(format: "MM/dd/yyyy"))
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
