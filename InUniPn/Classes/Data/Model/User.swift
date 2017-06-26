//
//  User.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class User {

    let userId: String

    var accessToken: String?
    var displayName: String?
    var email: String?
    var password: String?
    var imageUrl: String?

    init(withId id: String) {
        self.userId = id
    }

}

class UserFactory {

    static func user(withId id: String, name: String, email: String, password: String, andToken token: String) -> User {
        let user = User(withId: id)
        user.displayName = name
        user.email = email
        user.password = password
        user.accessToken = token
        return user
    }
}
