///  File: Sources/App/Modules/User/Templates/Html/UserIndexTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct UserIndexTemplate: TemplateRepresentable {
    var usersContext: UsersContext

    init(_ usersContext: UsersContext) {
        self.usersContext = usersContext
    }

    /// Template for the user index page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("List All Users")
            }
            Body {
                H1("List All Users")
                Table {
                    if usersContext.users.isEmpty {
                        Tr { Td() }
                        Tr {
                            Th("There are no users for this user yet.").colspan(2).style("text-align:left")
                        }
                    } else {
                        Tr {
                            Td("Note: Update and Delete are accesible thru Show.")
                        }
                        Tr { Td() }
                        Tr {
                            Th("Name").style("text-align:left")
                            Th("Password").style("text-align:left")
                            Th("Expires").style("text-align:left")
                            Th("Temporary").style("text-align:left")
                            Th("Expires").style("text-align:left")
                            Th("Token").style("text-align:left")
                            Th("Expires").style("text-align:left")
                        }
                        for userContext in usersContext.users {
                            Tr {
                                Td(userContext.userName)
                                Td(userContext.userPassword)
                                Td(userContext.userPasswordExpires.toString(format: "MM/dd/yyyy"))
                                Td(userContext.temporaryPassword)
                                Td(userContext.temporaryPasswordExpires.toString(format: "MM/dd/yyyy"))
                                Td(userContext.userToken)
                                Td(userContext.userTokenExpires.toString(format: "MM/dd/yyyy"))
                                // GET by Form Button
                                Td {
                                    Form {
                                        Input().type(.hidden).name("userId").value(userContext.userId)
                                        Button("Show")
                                            .type(.submit)
                                            .name("show-submit")
                                            .formaction("/user/show")
                                            .formmethod(.get)
                                            .formenctype(.urlencoded)
                                    }.name("show-form")
                                }

                            }.style("background-color: #F0F0FF")
                        }
                    }
                }
                Br()
                A("Add a New User").name("user-add").href("/user/add")
                Br()
                A("Home").name("home").href("/")
            }
        }
        .lang("en-US")
    }
}
