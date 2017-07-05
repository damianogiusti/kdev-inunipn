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

    func loginUser(withEmail email: String, password: String,
                   onSuccess: @escaping (User) -> Void, onError: @escaping (Error) -> Void) {

        let parameters: Alamofire.Parameters = [
            "email": email,
            "password": password
        ]

        postRestCall(toUrl: Addresses.authLogin.url(), withParams: parameters, onSuccess: { (json) in
            // create user after successful login
            let response = AuthResponse(fromJson: json)
            let user = UserFactory.user(withId: response.id, name: "", email: email, imageUrl: "",
                                        andToken: response.token)
            onSuccess(user)
        }, onError: onError)
    }

    func registerUser(withName name: String, email: String, password: String, andUniversityCode uni: String,
                      onSuccess: @escaping (User) -> Void, onError: @escaping (Error) -> Void) {
        
        let parameters: Alamofire.Parameters = [
            "email": email,
            "password": password
        ]

        postRestCall(toUrl: Addresses.authRegistration.url(), withParams: parameters, onSuccess: { (json) in
            // create user after successful registration
            let response = AuthResponse(fromJson: json)
            let user = UserFactory.user(withId: response.id, name: name, email: email, imageUrl: "", universityCode: uni,
                                        andToken: response.token)
            onSuccess(user)
        }, onError: onError)
    }

}
