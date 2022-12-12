///  File: Sources/App/Modules/User/Templates/Contexts/UserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

struct UserContext: Content {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var passwordHash: String = ""
    var administrator: String = ""

    init() {}

    // Fills in the UserContext from a UserModel
    // The model must contain a valid user
    init(model user: UserModel) {
        self.id = user.id!.uuidString
        self.name = user.name
        self.email = user.email
        self.passwordHash = user.passwordHash
        self.administrator = user.administrator
    }

    // Creates a new UserContext given parameters
    init(id: String, name: String, email: String, passwordHash: String, administrator: String) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.administrator = administrator
    }
}
