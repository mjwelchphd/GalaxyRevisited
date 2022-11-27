///  File: Sources/App/Modules/User/Templates/Html/UserAddTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml
import Foundation

struct UserAddTemplate: TemplateRepresentable {

    let distantFutureString = Date.distantFuture.toString(format: "MM/dd/yyyy")

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
                    Input().type(.hidden).name("userId").value("")
                    Input().type(.hidden).name("userPasswordExpires").value(distantFutureString)
                    Input().type(.hidden).name("temporaryPasswordExpires").value(distantFutureString)
                    Input().type(.hidden).name("userTokenExpires").value(distantFutureString)
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
                                Label("Temporary Password:").for("temporaryPassword")
                            }
                            Td {
                                Input().type(.text).name("temporaryPassword").value("")
                            }
                        }.style("background-color: #F0F0FF")

                        Tr {
                            Td {
                                Label("User Token:").for("userToken")
                            }
                            Td {
                                Input().type(.text).name("userToken").value("")
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
