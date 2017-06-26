//
//  AuthenticationManager.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

enum AuthErrors: Error {
    case badCredentials
}

final class AuthenticationManager: AuthenticationProtocol {

    private lazy var authService: AuthService = {
        return AuthService()
    }()

    private lazy var facebookService: FacebookService = {
        return FacebookService()
    }()

    func loginUser(usingSocial: Bool = false, withName name: String, andPassword password: String,
                   onSuccess: @escaping SuccessBlock<Any>, onError: @escaping ErrorBlock) {

        if (usingSocial) {

        } else {
            authService.loginUser(withName: name, andPassword: password, onSuccess: { (response) in
                // todo: create user from json
            }, onError: { (error) in
                onError(AuthErrors.badCredentials)
            })
        }
        
    }

    func registerUser(withName name: String, andPassword password: String, onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {

    }

}
