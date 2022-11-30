///  File: Sources/App/Modules/Authentication/Templates/Contexts/SignInContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

struct SignInContext: Content {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    init() {}
}
