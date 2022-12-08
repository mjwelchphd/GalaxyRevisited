///  File: Sources/App/Modules/User/Models/UserModel.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

final class UserModel: Model, Content {
    // Name of the table or collection
    static let schema = "users"

    // Unique identifier for this User
    @ID(key: .id) var id: UUID?

    @Field(key: "name") var name: String
    @Field(key: "email") var email: String
    @Field(key: "password_hash") var passwordHash: String

    // Creates a new, empty User
    init() { }

    init(id: UUID? = nil, name: String, email: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
    }

    // Call here to create a new record
    init(new user: UserContext) {
        self.id = nil
        update(update: user)
    }

    // Call here to update a record already in a model
    func update(update user: UserContext) {
        self.name = user.name
        self.email = user.email
        self.passwordHash = user.passwordHash
    }
}
