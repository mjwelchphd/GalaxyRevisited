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
    let administrator: String

    // Fills in the AuthenticatedUser from parameters
    init(id: UUID, name: String, email: String, administrator: String) {
        self.id = id
        self.name = name
        self.email = email
        self.administrator = administrator
    }

    // Fills in the AuthenticatedUser from a UserModel
    // The model must contain a valid user
    init(model user: UserModel) {
        self.id = user.id!
        self.name = user.name
        self.email = user.email
        self.administrator = user.administrator
    }
}

// This is needed because certain stuff in fixed in Vapor authenticate
extension AuthenticatedUser: SessionAuthenticatable {
    public var sessionID: UUID { id }
}

// This is added to Request to make it easier to check for an administrator
extension Request {
    // Gets the AuthenticatedUser if any, and returns a Bool
    func isAdministrator() -> Bool {
        guard let authenticatedUser = self.auth.get(AuthenticatedUser.self) else {
            return false
        }
        return authenticatedUser.administrator == "Y"
    }
}
