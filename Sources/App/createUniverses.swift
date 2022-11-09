///  File: Sources/App/createUniverses.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

/// Called from the startup page using the link, and before tests are run. A set of 7
/// galaxies with some stars is created. This method is used to provide instant test data.
func createUniverses(db: Database) async throws {

    // Remove all existing records
    try await StarModel.query(on: db).delete()
    try await GalaxyModel.query(on: db).delete()

    // Add galaxies and stars
    var galaxy = GalaxyModel(name: "Milky Way Galaxy", magnitude: -6.5, distance: 0, constellation: "Sagittarius")
    try await galaxy.save(on: db)
    try await StarModel(name: "Sun", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Betelgeuse", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Antares", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Core Worlds", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Rigel", galaxyId: galaxy.id!).save(on: db)

    galaxy = GalaxyModel(name: "Large Magellanic Cloud", magnitude: 0.9, distance: 160, constellation: "Dorado/Mensa")
    try await galaxy.save(on: db)
    try await StarModel(name: "R71", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "F439W (blue)", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "F547W (green)", galaxyId: galaxy.id!).save(on: db)

    galaxy = GalaxyModel(name: "Andromeda Galaxy", magnitude: 3.4, distance: 2500, constellation: "Andromeda")
    try await galaxy.save(on: db)
    try await StarModel(name: "Alpheratz – α Andromedae", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Mirach – β Andromedae", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Almach – γ Andromedae", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Adhil – ξ Andromedae", galaxyId: galaxy.id!).save(on: db)

    galaxy = GalaxyModel(name: "Triangulum Galaxy", magnitude: 5.7, distance: 2900, constellation: "Triangulum")
    try await galaxy.save(on: db)
    try await StarModel(name: "NGC 598", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Beta Trianguli", galaxyId: galaxy.id!).save(on: db)

    galaxy = GalaxyModel(name: "Centaurus A", magnitude: 6.84, distance: 13700, constellation: "Centaurus")
    try await galaxy.save(on: db)
    try await StarModel(name: "Theta Centauri", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Proxima Centauri", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Gamma Centauri", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Epsilon Centauri", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Delta Centauri", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "Nu Centauri", galaxyId: galaxy.id!).save(on: db)

    galaxy = GalaxyModel(name: "Bode's Galaxy", magnitude: 6.94, distance: 12000, constellation: "Ursa Major")
    try await galaxy.save(on: db)
    try await StarModel(name: "M81", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "M82", galaxyId: galaxy.id!).save(on: db)

    galaxy = GalaxyModel(name: "Sculptor Galaxy", magnitude: 7.2, distance: 12000, constellation: "Sculptor")
    try await galaxy.save(on: db)
    try await StarModel(name: "HD 4208", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "HD 4113", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "HD 9578", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "WASP-8", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "WASP-45", galaxyId: galaxy.id!).save(on: db)
    try await StarModel(name: "WASP-29", galaxyId: galaxy.id!).save(on: db)
}
