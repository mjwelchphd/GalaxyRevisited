///  File: Sources/App/Modules/User/Templates/Contexts/UserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

struct AuthenticatedUser: Authenticatable {
    let id: UUID
    let name: String
    let email: String

    public init(id: UUID, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }

    // Fills in the UserContext from a UserModel
    // The model must contain a valid user
    init(model user: UserModel) {
        self.id = user.id!
        self.name = user.name
        self.email = user.email
    }
}

extension AuthenticatedUser: SessionAuthenticatable {
    public var sessionID: UUID { id }
}
