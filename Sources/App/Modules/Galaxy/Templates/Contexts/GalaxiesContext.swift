///  File: Sources/App/Modules/Galaxy/Templates/Contexts/GalaxiesContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SQLKit

/// Used to move a list of GalaxyContexts between the model and the Index view.
struct GalaxiesContext {

    var galaxies: [GalaxyContext]

    /// Create empty context
    init() {
        self.galaxies = []
    }

    /// Create GalaxiesContext with only one galaxy from a model: not used in GalaxyRevisited
    init(one: GalaxyModel) {
        self.galaxies = [GalaxyContext(model: one)]
    }

    /// Create GalaxiesContext with many galaxies from a model
    init(many: [GalaxyModel]) {
        self.galaxies = many.compactMap { GalaxyContext(model: $0) }
    }
}
