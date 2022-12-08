///  File: Sources/App/Modules/Authentication/Templates/Contexts/AuthenticatedUserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

struct AuthenticatedUser: Authenticatable {
    let id: UUID
    let name: String
    let email: String

    // Fills in the AuthenticatedUser from parameters
    init(id: UUID, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }

    // Fills in the AuthenticatedUser from a UserModel
    // The model must contain a valid user
    init(model user: UserModel) {
        self.id = user.id!
        self.name = user.name
        self.email = user.email
    }
}

// This is needed because certain stuff in fixed in Vapor authenticate
extension AuthenticatedUser: SessionAuthenticatable {
    public var sessionID: UUID { id }
}
