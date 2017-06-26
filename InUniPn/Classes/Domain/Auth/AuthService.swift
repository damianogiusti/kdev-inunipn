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
    case
    registration = "apiunipn.parol.in/V1/user/signup",
    login = "apiunipn.parol.in/V1/user/login"
}

class AuthService: BaseService {

    func loginUser(withName name: String, andPassword password: String,
                   onSuccess: @escaping (AuthResponse) -> Void, onError: @escaping (Error) -> Void) {

        let parameters: Alamofire.Parameters? = [
            "email": name,
            "password": password
        ]

        Alamofire.request(AuthPaths.login.rawValue,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default)
            .validate()
            .responseJSON { (response) in
                if let error = response.error {
                    onError(error)
                } else if let data = response.data {
                    onSuccess(AuthResponse(fromJson: JSON(data: data)))
                }
        }

    }

    func registerUser(withName name: String, andPassword password: String, onSuccess: (Any) -> Void, onError: (Error) -> Void) {

    }

}
