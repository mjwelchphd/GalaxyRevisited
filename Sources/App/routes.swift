///  File: Sources/App/routes.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: WelcomeController())
    try app.register(collection: GalaxyController())
    try app.register(collection: StarController())
    try app.register(collection: UserController())
    try app.register(collection: UserAuthenticationController())

    // Display the routes for debugging the routes list
    /* print("--- routes ---")
    for route in app.routes.all {
        print(route)
    }
    print()*/
}
