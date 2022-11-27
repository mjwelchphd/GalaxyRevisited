///  File: Sources/App/Modules/User/Templates/Contexts/UserIdContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

struct UserIdContext: PairableContent {
    var userId: String = ""

    init() {}

    init(userId: String) {
        self.userId = userId
    }

    init(pairs: [String: String]) {
        if let userId = pairs["userId"] { self.userId = userId }
    }
}
