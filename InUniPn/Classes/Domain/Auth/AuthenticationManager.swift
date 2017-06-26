//
//  AuthenticationManager.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

enum AuthErrors: Error {
    case badCredentials, socialLoginError, errorSavingUser
}

final class AuthenticationManager: AuthenticationProtocol {

    private let usersRepository: UsersRepository = RepositoryFactory.usersRepository

    private lazy var authService: AuthService = {
        return AuthService()
    }()

    private lazy var facebookService: FacebookService = {
        return FacebookService()
    }()

    func loginUser(usingSocial: Bool = false, withName name: String, andPassword password: String,
                   onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock) {

        runInBackground { [weak self] in

            if (usingSocial) {
                self?.facebookService.loginUser(withName: name, andPassword: password, onSuccess: { (response) in
                    // todo: create user from json
                }, onError: { (error) in
                    runOnUiThread {
                        onError(AuthErrors.socialLoginError)
                    }
                })

            } else {
                self?.authService.loginUser(withName: name, andPassword: password, onSuccess: { [weak self] (response) in

                    // create user after successful login

                    let user = User(withId: response.id)
                    user.accessToken = response.token
                    user.email = name
                    user.password = password

                    // store user

                    if let success = self?.usersRepository.save(user: user), success {
                        runOnUiThread {
                            onSuccess(user)
                        }
                    } else {
                        runOnUiThread {
                            onError(AuthErrors.errorSavingUser)
                        }
                    }

                    }, onError: { (error) in
                        runOnUiThread {
                            onError(AuthErrors.badCredentials)
                        }
                })
            }
        }
    }

    func registerUser(withName name: String, andPassword password: String, onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {

    }

}
