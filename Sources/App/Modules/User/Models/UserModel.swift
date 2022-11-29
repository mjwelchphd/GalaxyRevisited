///  File: Sources/App/Modules/User/Models/UserModel.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import Fluent

final class UserModel: Model, Content, Authenticatable {
    // Name of the table or collection
    static let schema = "users"

    // Unique identifier for this User
    @ID(key: .id) var id: UUID?

    @Field(key: "user_name") var userName: String
    @Field(key: "user_password") var userPassword: String
    @Field(key: "user_password_expires") var userPasswordExpires: Date
    @Field(key: "temporary_password") var temporaryPassword: String
    @Field(key: "temporary_password_expires") var temporaryPasswordExpires: Date
    @Field(key: "user_token") var userToken: String
    @Field(key: "user_token_expires") var userTokenExpires: Date

    // Creates a new, empty User
    init() { }

    init(id: UUID? = nil, userName: String, userPassword: String, userPasswordExpires: Date, temporaryPassword: String, temporaryPasswordExpires: Date, userToken: String) {
        self.id = id
        self.userName = userName
        self.userPassword = userPassword
        self.userPasswordExpires = userPasswordExpires
        self.temporaryPassword = temporaryPassword
        self.temporaryPasswordExpires = temporaryPasswordExpires
        self.userToken = userToken
        self.userTokenExpires = userPasswordExpires
    }

    // Call here to create a new record
    init(new user: UserContext) {
        self.id = nil
        update(update: user)
    }

    // Call here to update a record already in a model
    func update(update user: UserContext) {
        self.userName = user.userName
        self.userPassword = user.userPassword
        self.userPasswordExpires = user.userPasswordExpires
        self.temporaryPassword = user.temporaryPassword
        self.temporaryPasswordExpires = user.temporaryPasswordExpires
        self.userToken = user.userToken
        self.userTokenExpires = user.userTokenExpires
    }
}
