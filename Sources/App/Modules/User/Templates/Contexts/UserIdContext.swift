///  File: Sources/App/Modules/User/Templates/Contexts/UserIdContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

// This version is used for everything except "save" and "update"
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

// This version is used for "save" and "update" and the normal one for everything else
struct UserIdContextWithPassword: Codable {
    var id: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    init() {}

    init(id: String, password: String, confirmPassword: String) {
        self.id = id
    }
}
