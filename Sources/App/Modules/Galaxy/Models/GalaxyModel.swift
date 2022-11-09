///  File: Sources/App/Modules/Galaxy/Models/GalaxyModel.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Fluent
import Vapor

final class GalaxyModel: Model {
    // Name of the table or collection
    static let schema = "galaxies"

    // Unique identifier for this Galaxy
    @ID(key: .id) var id: UUID?

    // The Galaxy's name and demographics
    @Field(key: "name") var name: String
    @Field(key: "magnitude") var magnitude: Float
    @Field(key: "distance") var distance: Int
    @Field(key: "constellation") var constellation: String

    // Reference to the the Stars is in this Galaxy
    @Children(for: \.$galaxy) var stars: [StarModel]

    // Creates a new, empty Galaxy
    init() { }

    // This is used, in particular, in create_universe.swift
    init(name: String, magnitude: Float, distance: Int, constellation: String) {
        self.id = nil
        self.name = name
        self.magnitude = magnitude
        self.distance = distance
        self.constellation = constellation
    }

    // Call here to create a new record
    init(new galaxy: GalaxyContext) {
        self.id = nil
        update(update: galaxy)
    }

    // Call here to update a record already in a model
    func update(update galaxy: GalaxyContext) {
        self.name = galaxy.name
        self.magnitude = galaxy.magnitude
        self.distance = galaxy.distance
        self.constellation = galaxy.constellation
    }
}
