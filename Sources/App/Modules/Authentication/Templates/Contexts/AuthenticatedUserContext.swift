///  File: Sources/App/Modules/User/Templates/Contexts/UserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

struct AuthenticatedUser: Content, Authenticatable {
    var id: String = ""
    var name: String = ""
    var email: String = ""

    init() {}

    // Fills in the UserContext from a UserModel
    // The model must contain a valid user
    init(model user: UserModel) {
        self.id = user.id!.uuidString
        self.name = user.name
        self.email = user.email
    }
}
