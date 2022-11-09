///  File: Sources/App/Modules/Star/Templates/Html/StarIndexTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct StarIndexTemplate: TemplateRepresentable {
    var starsContext: StarsContext

    init(_ starsContext: StarsContext) {
        self.starsContext = starsContext
    }

    /// Template for the star index page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("List All Stars")
            }
            Body {
                H1("List All Stars for \(starsContext.galaxyName)")
                Table {
                    if starsContext.stars.isEmpty {
                        Tr { Td() }
                        Tr {
                            Th("There are no stars for this galaxy yet.").colspan(2).style("text-align:left")
                        }
                    } else {
                        Tr {
                            Td("Note: Update and Delete are accesible thru Show.")
                        }
                        Tr { Td() }
                        Tr {
                            Th("Name").style("text-align:left")
                        }
                        Tr {
                            Td {
                                Label("Galaxy ID:")
                            }
                            Td {
                                Tag(starsContext.galaxyId)
                            }
                        }.style("background-color: #F0F0FF")
                        for star in starsContext.stars {
                            let starId = star.starId
                            Tr {
                                Td(star.name)
                                // GET Route Parameter
                                Td { // GET Form
                                    Form {
                                        Input().type(.hidden).value(starsContext.galaxyId).name("galaxyId")
                                        Input().type(.hidden).value(starsContext.galaxyName).name("galaxyName")
                                        Input().type(.hidden).value(starId).name("starId")
                                        Button("Show")
                                            .type(.submit)
                                            .name("show-submit")
                                            .formaction("/star/show")
                                            .formmethod(.get)
                                            .formenctype(.urlencoded)
                                    }.name("show-form")
                                }
                            }.style("background-color: #F0F0FF")
                        }
                    }
                }
                Br()
                Form {
                    Input().type(.hidden).name("galaxyId").value(starsContext.galaxyId)
                    Input().type(.hidden).name("galaxyName").value(starsContext.galaxyName)
                    Input().type(.hidden).name("starId").value("")
                    Button("Add a New Star")
                        .type(.submit)
                        .name("add-submit")
                        .formaction("/star/add")
                        .formmethod(.get)
                        .formenctype(.urlencoded)
                }.name("add-form")
                Br()
                A("Home").name("home").href("/")
                Br()
                A("Show galaxy").name("show-galaxy").href("/galaxy/show2?galaxyId=\(starsContext.galaxyId)")
            }
        }
        .lang("en-US")
    }
}
