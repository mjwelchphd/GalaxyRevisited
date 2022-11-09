///  File: Sources/App/Modules/Galaxy/Templates/Html/GalaxyShowTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

/// Shows a galaxy passed in as a GalaxyContext. Here, the galaxyId (UUID)
/// is shown using a Tag so that the user cannot change the UUID. Normally, the UUID would not
/// even be shown, i.e., it is nothing the user would normally see, but something the app would look
/// up. In Galaxy Revisited the list galaxies picks up the UUIDs from the database, but
/// the user picks a galaxy from a list (presumably) from the galaxy name. The user never needs to
/// see the UUID, but since this is a demonstration app, it is shown on this page. Notice that the
/// links have names for testing.
struct GalaxyShowTemplate: TemplateRepresentable {
    var galaxyContext: GalaxyContext

    init(_ context: GalaxyContext) {
        self.galaxyContext = context
    }

    /// Template for the show a galaxy page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("Show A Galaxy")
            }
            Body {
                H1("Show A Galaxy")
                Form {
                    Input().type(.hidden).name("galaxyId").value(galaxyContext.galaxyId)
                    Input().type(.hidden).name("galaxyName").value(galaxyContext.name)
                    Input().type(.hidden).name("starId").value("") // for List Stars below
                    Table {
                        Tr {
                            Td { Label("Galaxy ID:").for("name") }
                            Td { Tag(galaxyContext.galaxyId).id("name") }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("Galaxy Name:").for("name") }
                            Td { Input().type(.text).name("name").value(galaxyContext.name) }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("      Magnitude:").for("magnitude") }
                            Td { Input().type(.text).name("magnitude").value(String(galaxyContext.magnitude)) }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("       Distance:").for("distance") }
                            Td { Input().type(.text).name("distance").value(String(galaxyContext.distance)) }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td { Label("  Constallation:").for("constellation") }
                            Td { Input().type(.text).name("constellation").value(galaxyContext.constellation) }
                        }.style("background-color: #F0F0FF")
                        Tr {
                            Td {
                                Button("Update")
                                    .type(.submit)
                                    .name("update")
                                    .formaction("/galaxy/update")
                                    .formmethod(.post)
                                Button("Delete")
                                    .type(.submit)
                                    .name("delete")
                                    .formaction("/galaxy/delete")
                                    .formmethod(.post)
                                Button("List Stars")
                                    .type(.submit)
                                    .name("show-stars")
                                    .formaction("/star/index")
                                    .formmethod(.get)
                            }
                        }
                    }
                }.name("show-galaxy-form")
                Br()
                A("Home").name("home").href("/")
                Br()
                A("List all galaxies").name("show-galaxies").href("/galaxy/index")
            }
        }
        .lang("en-US")
    }
}
