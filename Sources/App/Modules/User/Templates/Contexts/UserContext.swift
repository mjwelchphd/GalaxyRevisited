///  File: Sources/App/Modules/User/Templates/Contexts/UserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

struct UserContext: Content {
    var userId: String = ""
    var userName: String = ""
    var userPassword: String = ""
    var userPasswordExpires: Date = Date()
    var temporaryPassword: String = ""
    var temporaryPasswordExpires: Date = Date()
    var userToken: String = ""
    var userTokenExpires: Date = Date()

    init() {}

    // Fills in the UserContext from a UserModel
    // The model must contain a valid user
    init(model user: UserModel) {
        self.userId = user.id!.uuidString
        self.userName = user.userName
        self.userPassword = user.userPassword
        self.userPasswordExpires = user.userPasswordExpires
        self.temporaryPassword = user.temporaryPassword
        self.temporaryPasswordExpires = user.temporaryPasswordExpires
        self.userToken = user.userToken
        self.userTokenExpires = user.userTokenExpires
    }

    // Creates a new UserContext given parameters
    init(id: String, userName: String, userPassword: String, userPasswordExpires: Date, temporaryPassword: String, temporaryPasswordExpires: Date, userToken: String, userTokenExpires: Date) {
        self.userId = id
        self.userName = userName
        self.userPassword = userPassword
        self.userPasswordExpires = userPasswordExpires
        self.temporaryPassword = temporaryPassword
        self.temporaryPasswordExpires = temporaryPasswordExpires
        self.userToken = userToken
        self.userTokenExpires = userTokenExpires
    }

    // Fills in the UserContext from a UserModel
    // The model must contain a valid user
    init(decoded user: UserDecodeContext) {
        self.userId = user.userId
        self.userName = user.userName
        self.userPassword = user.userPassword
        self.userPasswordExpires = user.userPasswordExpires.toDate(format: "MM/dd/yyyy")!
        self.temporaryPassword = user.temporaryPassword
        self.temporaryPasswordExpires = user.temporaryPasswordExpires.toDate(format: "MM/dd/yyyy")!
        self.userToken = user.userToken
        self.userTokenExpires = user.userTokenExpires.toDate(format: "MM/dd/yyyy")!
    }
}
