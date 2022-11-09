///  File: Sources/App/Modules/Star/Templates/Contexts/StarsContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SQLKit

struct StarsContext {

    let galaxyId: String
    let galaxyName: String
    let stars: [StarContext]

    init() {
        self.galaxyId = ""
        self.galaxyName = ""
        self.stars = [ StarContext(starId: "", name: "") ]
    }

    init(one: StarModel?, parent: GalaxyModel) {
        self.galaxyId = parent.id!.uuidString
        self.galaxyName = parent.name
        if let star = one {
            self.stars = [StarContext(starId: String(star.id!), name: star.name)]
        } else {
            self.stars = []
        }
    }

    init(many: [StarModel], parent: GalaxyModel) {
        self.galaxyId = parent.id!.uuidString
        self.galaxyName = parent.name
        self.stars = many.compactMap { StarContext(starId: String($0.id!), name: $0.name) }
    }
}
