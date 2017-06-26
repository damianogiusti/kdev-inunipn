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
