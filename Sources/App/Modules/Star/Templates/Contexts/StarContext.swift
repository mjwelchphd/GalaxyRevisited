///  File: Sources/App/Modules/Star/Templates/Contexts/StarContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SQLKit

struct StarContext: Content {
    var starId: String = ""
    var name: String = ""

    init() {}

    // Fills in the StarContext from a StarModel
    // The model must contain a valid star
    init(model star: StarModel) {
        self.starId = star.id!.uuidString
        self.name = star.name
    }

    init(starId: String = "", name: String) {
        self.starId = starId
        self.name = name
    }
}
