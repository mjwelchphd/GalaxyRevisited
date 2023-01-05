///  File: Sources/App/Templates/MenuTemplate.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SwiftHtml

struct MenuTemplate: TemplateRepresentable {

    /// Template for the user index page.
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Link(rel: .stylesheet).href("/Resources/Css/Menu.css")
        Div {
            A("Welcome").href("/")
            Div {
                Button("Home").class("dropbtn")
                Div {
                    A("Create - restore the test galaxies and stars").name("create").href("/create-universes")
                }.class("dropdown-content")
            }.class("dropdown")
            Div {
                Button("Galaxies").class("dropbtn")
                Div {
                    A("List All Galaxies").href("/galaxy/index")
                    A("Add A New Galaxy").name("add").href("/galaxy/add")
                }.class("dropdown-content")
            }.class("dropdown")
            if req.isAdministrator() {
                Div {
                    Button("Administrator").class("dropbtn")
                    Div {
                        A("List All Users").name("list-all-users").href("/user/index")
                    }.class("dropdown-content")
                }.class("dropdown")
            }
            if req.auth.has(AuthenticatedUser.self) {
                A("Sign Out").name("sign-out").href("/sign-out")
            } else {
                A("Sign In").name("sign-in").href("/sign-in")
            }
        }.class("navbar")
    }
}
