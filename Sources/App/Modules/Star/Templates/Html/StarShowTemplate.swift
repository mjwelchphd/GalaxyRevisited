///  File: Sources/App/Modules/Star/Templates/Html/StarShowTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct StarShowTemplate: TemplateRepresentable {
    var starContext: StarContext
    var starIdContext: StarIdContext

    init(_ starContext: StarContext, _ starIdContext: StarIdContext) {
        self.starContext = starContext
        self.starIdContext = starIdContext
    }

    /// Template for the star show page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Show A Star")
            }
            Body {
                H1("Show a Star for \(starIdContext.galaxyName)")
                Form {
                    Input().type(.hidden).name("galaxyId").value(starIdContext.galaxyId)
                    Input().type(.hidden).name("starId").value(starIdContext.starId)
                    Table {
                        Tr {
                            Td {
                                Label("Galaxy ID:")
                            }
                            Td {
                                Tag(starIdContext.galaxyId)
                            }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Label("Star ID:")
                            }
                            Td {
                                Tag(starIdContext.starId)
                            }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Label("Star Name:").for("name")
                            }
                            Td {
                                Input().type(.text).name("name").value(starContext.name)
                            }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Button("Update")
                                    .type(.submit)
                                    .name("update")
                                    .formaction("/star/update")
                                    .formmethod(.post)
                                Button("Delete")
                                    .type(.submit)
                                    .name("delete")
                                    .formaction("/star/delete")
                                    .formmethod(.post)
                            }
                        }
                    }
                }.name("show-star-form")
                Br()
                A("Home").name("home").href("/")
                Br()
                A("Show galaxy").name("show-galaxy").href("/galaxy/show2?galaxyId=\(starIdContext.galaxyId)")
                Br()
                A("List all stars").name("list-all-stars")
                    .href("/star/index?galaxyId=\(starIdContext.galaxyId)&galaxyName=&starId=")
            }
        }
        .lang("en-US")
    }
}
