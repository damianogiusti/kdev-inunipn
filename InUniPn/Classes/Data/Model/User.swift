//
//  User.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    static let k_json_id = "id"
    static let k_json_email = "email"
    static let k_json_fullname = "name"
    
    static let k_json_picture = "picture"
    static let k_json_picture_data = "data"
    static let k_json_picture_url = "url"

    let userId: String

    var accessToken: String?
    var displayName: String?
    var email: String?
    var imageUrl: String?
    var university: String?

    init(withId id: String) {
        self.userId = id
    }

}

class UserFactory {

    static func user(withId id: String, name: String, email: String, imageUrl: String, andToken token: String) -> User {
        let user = User(withId: id)
        user.displayName = name
        user.email = email
        user.imageUrl = imageUrl
        user.accessToken = token
        return user
    }
    
    static func user(fromJson json: JSON, withToken token: String) -> User {
        let user = User(withId: json[User.k_json_id].string ?? "")
        user.displayName = json[User.k_json_fullname].string ?? ""
        user.email = json[User.k_json_email].string ?? ""
        user.accessToken = token
        user.imageUrl = json[User.k_json_picture][User.k_json_picture_data][User.k_json_picture_url].string ?? ""
        return user
    }
}
