//
//  DMUser.swift
//  InUniPn
//
//  Created by Damiano Giusti on 05/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import RealmSwift

class DMUser: Object {

    dynamic var userId: String = UUID().uuidString

    dynamic var accessToken: String?
    dynamic var displayName: String?
    dynamic var email: String?
    dynamic var imageUrl: String?
    dynamic var university: String?

    convenience init(withId id: String) {
        self.init()
        self.userId = id
    }

    override class func primaryKey() -> String {
        return "userId"
    }

}
