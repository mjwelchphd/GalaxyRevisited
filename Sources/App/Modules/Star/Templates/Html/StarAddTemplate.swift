///  File: Sources/App/Modules/Star/Templates/Html/StarAddTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct StarAddTemplate: TemplateRepresentable {
    var starIdContext: StarIdContext

    init(_ starIdContext: StarIdContext) {
        self.starIdContext = starIdContext
    }

    /// Template for the star add page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Add A Star")
            }
            Body {
                H1("Add a New Star for \(starIdContext.galaxyName)")
                Form {
                    Input().type(.hidden).name("galaxyId").value(starIdContext.galaxyId)
                    Input().type(.hidden).name("galaxyName").value(starIdContext.galaxyName)
                    Input().type(.hidden).name("starId").value("")
                    Table {
                        Tr {
                            Td { Label("New Star Name:").for("name") }
                            Td { Input().type(.text).name("name").value("") }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Button("Save")
                                    .type(.submit)
                                    .name("save")
                                    .formaction("/star/save")
                                    .formmethod(.post)
                                    .formenctype(.urlencoded)
                            }
                        }
                    }
                }.name("add-star-form")
                Br()
                A("List all stars").name("list-all-stars")
                    .href("/star/index?galaxyId=\(starIdContext.galaxyId)&galaxyName=&starId=")
                Br()
                A("Home").name("home").href("/")
            }
        }
        .lang("en-US")
    }
}
