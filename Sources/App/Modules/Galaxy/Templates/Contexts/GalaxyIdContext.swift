///  File: Sources/App/Modules/Galaxy/Templates/Contexts/GalaxyIdContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

/// Used to decode a received UUID.
struct GalaxyIdContext: PairableContent {
    var galaxyId: String = ""

    init() {}

    /// Receive a galaxy UUID from a request.
    init(galaxyId: String) {
        self.galaxyId = galaxyId
    }

    /// Create a context from a list of name:value pairs during testing.
    init(pairs: [String: String]) {
        if let galaxyId = pairs["galaxyId"] { self.galaxyId = galaxyId }
    }
}
