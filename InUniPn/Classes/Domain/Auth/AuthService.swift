//
//  AuthService.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum AuthPaths: String {
    case login = "apiunipn.parol.in/V1/user/signup"
}

class AuthService: BaseService {



    func loginUser(withName name: String, andPassword password: String, onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {

        Alamofire.request(AuthPaths.login.rawValue).responseJSON { (response) in
            if let error = response.error {
                onError(error)
            } else if let data = response.data {
                onSuccess(JSON(data: data))
            }
        }

    }

    func registerUser(withName name: String, andPassword password: String, onSuccess: (Any) -> Void, onError: (Error) -> Void) {

    }

}
