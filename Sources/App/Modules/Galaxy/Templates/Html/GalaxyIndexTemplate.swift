///  File: Sources/App/Modules/Galaxy/Templates/Html/GalaxyIndexTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

/// Creates a page with a list of all the galaxies in the database. The list
/// is read from the database by the controller, copied to a GaxaliesContext and passed in here
/// as a parameter. This page demonstrates 3 ways to pass parameters to the subsequent page
/// activate the show page, i.e., there are 3 ways to pass the UUID of the galaxy to be shown.
/// See the documentation for more details. Show-stars differs from show-3 primarily in the
/// number of parameters that are passed in the form of <input> statements.  Notice that the
/// links have names for testing.
struct GalaxyIndexTemplate: TemplateRepresentable {
    var galaxiesContext: GalaxiesContext

    init(_ galaxiesContext: GalaxiesContext) {
        self.galaxiesContext = galaxiesContext
    }

    /// Template for the galaxy index page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title("List All Galaxies")
            }
            Body {
                H1("List All Galaxies")
                Table {
                    Tr {
                        Td("Note: Update and Delete are accesible thru Show.")
                    }
                    Tr { Td() }
                    Tr {
                        Th("Name").style("text-align:left")
                        Th("Magnitude").style("text-align:left")
                        Th("Distance").style("text-align:left")
                        Th("Constallation").style("text-align:left")
                    }
                    for galaxyContext in galaxiesContext.galaxies {
                        Tr {
                            Td(galaxyContext.name)
                            Td(String(galaxyContext.magnitude))
                            Td(String(galaxyContext.distance))
                            Td(galaxyContext.constellation)

                            // GET by Route Parameter
                            Td { A("Show-1").name("show-1-link").href("/galaxy/show1/\(galaxyContext.galaxyId)") }

                            // GET by Query Link
                            Td { A("Show-2").name("show-2-link")
                                .href("/galaxy/show2?galaxyId=\(galaxyContext.galaxyId)")
                            }

                            // GET by Form Button
                            Td {
                                Form {
                                    Input().type(.hidden).name("galaxyId").value(galaxyContext.galaxyId)
                                    Button("Show-3")
                                        .type(.submit)
                                        .name("show-3-submit")
                                        .formaction("/galaxy/show2")
                                        .formmethod(.get)
                                        .formenctype(.urlencoded)
                                }.name("show-3-form")
                            }
                            
                            // Get stars
                            Td { // GET Form
                                Form {
                                    // send a StarIdContext.swift
                                    Input().type(.hidden).name("galaxyId").value(galaxyContext.galaxyId)
                                    Input().type(.hidden).name("galaxyName").value(galaxyContext.name)
                                    Input().type(.hidden).name("starId").value("")
                                    Button("List Stars")
                                        .type(.submit)
                                        .name("show-stars-submit")
                                        .formaction("/star/index")
                                        .formmethod(.get)
                                        .formenctype(.urlencoded)
                                }.name("show-stars-form")
                            }
                        }.style("background-color: #F0F0FF")
                    }
                    Tr { Td() }
                }
                Br()
                A("Home").name("home").href("/")
            }
        }.lang("en-US")
    }
}
