///  File: Sources/App/Modules/Galaxy/Templates/Contexts/GalaxyContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SQLKit

/// Used to move one galaxy between the model and a view.
struct GalaxyContext: Content {
    var galaxyId: String = ""
    var name: String = ""
    var magnitude: Float = 0.0
    var distance: Int = 0
    var constellation: String = ""

    init() {}

    /// Fills in the GalaxyContext from a GalaxyModel.
    /// The model must contain a valid galaxy.
    init(model galaxy: GalaxyModel) {
        self.galaxyId = galaxy.id!.uuidString
        self.name = galaxy.name
        self.magnitude = galaxy.magnitude
        self.distance = galaxy.distance
        self.constellation = galaxy.constellation
    }

    /// Fills in the GalaxyContext from input fields.
    /// This call is used for creating test data when running tests.
    init(id: String, name: String, magnitude: Float, distance: Int, constellation: String) {
        self.galaxyId = id
        self.name = name
        self.magnitude = magnitude
        self.distance = distance
        self.constellation = constellation
    }

}
