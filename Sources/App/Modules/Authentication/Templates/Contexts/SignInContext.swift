///  File: Sources/App/Modules/User/Templates/Contexts/UserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

struct SignInContext {
    let name: String
    let error: String?

    init(name: String, error: String?=nil) {
        self.name = name
        self.error = error
    }
}
