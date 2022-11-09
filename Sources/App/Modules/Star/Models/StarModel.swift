///  File: Sources/App/Modules/Star/Models/StarModel.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

final class StarModel: Model, Content {
    // Name of the table or collection
    static let schema = "stars"

    // Unique identifier for this Star
    @ID(key: .id) var id: UUID?

    // The Star's name
    @Field(key: "name") var name: String

    // Reference to the Galaxy this Star is in (not the whole galaxy)
    @Parent(key: "galaxyId") var galaxy: GalaxyModel

    // Creates a new, empty Star
    init() { }

    // This is used, in particular, in create_universe.swift
    init(id: UUID? = nil, name: String, galaxyId: UUID) {
        self.id = id
        self.name = name
        self.$galaxy.id = galaxyId
    }

    // Call here to create a new record
    init(new star: StarContext, galaxyId: UUID) {
        self.id = nil
        self.$galaxy.id = galaxyId
        update(update: star)
    }

    // Call here to update a record already in a model
    func update(update star: StarContext) {
        self.name = star.name
    }
}
