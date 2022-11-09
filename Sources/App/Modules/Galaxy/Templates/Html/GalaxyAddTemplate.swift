///  File: Sources/App/Modules/Galaxy/Templates/Html/GalaxyAddTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

/// Creates the page for a new, empty galaxy. Because it's a new
/// galaxy, the "galaxyId" is set to blank. Notice that the links have names for testing.
struct GalaxyAddTemplate: TemplateRepresentable {

    /// Template for the add a galaxy page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Add A New Galaxy")
            }
            Body {
                H1("Add A New Galaxy")
                Form {
                    Input().type(.hidden).name("galaxyId").value("")
                    Table {
                        Tr {
                            Td { Label("New Galaxy Name:").for("name") }
                            Td { Input().type(.text).name("name").value("") }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("      Magnitude:").for("magnitude") }
                            Td { Input().type(.text).name("magnitude").value("0.0") }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("       Distance:").for("distance") }
                            Td { Input().type(.text).name("distance").value("0") }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("  Constallation:").for("constellation") }
                            Td { Input().type(.text).name("constellation").value("") }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Button("Save")
                                    .type(.submit)
                                    .name("submit")
                                    .formaction("/galaxy/save")
                                    .formmethod(.post)
                            }
                        }
                    }
                }.name("save-galaxy-form")
                Br()
                A("List all galaxies").name("list-all-galaxies").href("/galaxy/index")
                Br()
                A("Home").name("home").href("/")
            }
        }
        .lang("en-US")
    }
}
