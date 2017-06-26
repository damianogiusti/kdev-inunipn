//
//  AuthResponse.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AuthResponse {

    let token: String
    let id: String

    init(fromJson json: JSON) {
        self.token = json["access_token"].string ?? ""
        self.id = json["id"].string ?? ""
    }

}
