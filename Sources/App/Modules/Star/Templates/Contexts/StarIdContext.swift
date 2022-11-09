///  File: Sources/App/Modules/Star/Templates/Contexts/StarIdContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

struct StarIdContext: PairableContent {
    var starId: String = ""
    var galaxyId: String = ""
    var galaxyName: String = ""

    init() {}

    init(starId: String, galaxyId: String, galaxyName: String) {
        self.starId = starId
        self.galaxyId = galaxyId
        self.galaxyName = galaxyName
    }

    init(pairs: [String: String]) {
        if let galaxyId = pairs["galaxyId"] { self.galaxyId = galaxyId }
        if let galaxyName = pairs["galaxyName"] { self.galaxyName = galaxyName }
        if let starId = pairs["starId"] { self.starId = starId }
    }
}
