///  File: Sources/App/Modules/User/Templates/Contexts/UsersContext.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 12/7/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor
import SQLKit

struct UsersContext {

    let users: [UserContext]

    init() {
        users = []
    }

    init(one: UserModel?) {
        if let user = one {
            self.users = [UserContext(model: user)]
        } else {
            self.users = []
        }
    }

    init(many: [UserModel]) {
        self.users = many.map { UserContext(model: $0) }
    }
}
