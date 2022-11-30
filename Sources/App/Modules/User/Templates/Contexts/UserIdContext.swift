///  File: Sources/App/Modules/User/Templates/Contexts/UserIdContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

struct UserIdContext: PairableContent {
    var id: String = ""

    init() {}

    init(id: String) {
        self.id = id
    }

    init(pairs: [String: String]) {
        if let id = pairs["id"] { self.id = id }
    }
}
