//
//  AuthService.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AuthService: BaseService, RestCapable {

    func loginUser(withName name: String, andPassword password: String,
                   onSuccess: @escaping (User) -> Void, onError: @escaping (Error) -> Void) {

        let parameters: Alamofire.Parameters = [
            "email": name,
            "password": password
        ]

        postRestCall(toUrl: Addresses.authLogin.url(), withParams: parameters, onSuccess: { (json) in
            // create user after successful login
            let response = AuthResponse(fromJson: json)
            let user = UserFactory.user(withId: response.id, name: "", email: name, password: password, andToken: response.token)
            onSuccess(user)
        }, onError: onError)
    }

    func registerUser(withName name: String, andPassword password: String, onSuccess: (Any) -> Void, onError: (Error) -> Void) {

    }

}
