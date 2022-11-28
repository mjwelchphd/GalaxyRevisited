///  File: Sources/App/Modules/User/Templates/Contexts/UserContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 11/18/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

struct UserContextUsingStringsForDates: Content {
    var userId: String = ""
    var userName: String = ""
    var userPassword: String = ""
    var userPasswordExpires: String = ""
    var temporaryPassword: String = ""
    var temporaryPasswordExpires: String = ""
    var userToken: String = ""
    var userTokenExpires: String = ""

    init() {}

    // Fills in the UserContext from a UserModel
    // The model must contain a valid user
    init(encoded user: UserContext) {
        self.userId = user.userId
        self.userName = user.userName
        self.userPassword = user.userPassword
        self.userPasswordExpires = user.userPasswordExpires.toString(format: "MM/dd/yyyy")
        self.temporaryPassword = user.temporaryPassword
        self.temporaryPasswordExpires = user.temporaryPasswordExpires.toString(format: "MM/dd/yyyy")
        self.userToken = user.userToken
        self.userTokenExpires = user.userTokenExpires.toString(format: "MM/dd/yyyy")
    }
}
