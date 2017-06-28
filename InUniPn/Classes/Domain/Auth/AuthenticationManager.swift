//
//  AuthenticationManager.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

enum AuthPaths: String {
    case
    registration = "apiunipn.parol.in/V1/user/signup",
    login = "apiunipn.parol.in/V1/user/login",
    socialLogin = "apiunipn.parol.in/V1/user/facebook/login"
}

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
    
    func loginUser(withName name: String, andPassword password: String,
                   onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock) {
        
        runInBackground { [weak self] in
            
            self?.authService.loginUser(withName: name, andPassword: password, onSuccess: { [weak self] (user) in
                
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
    
    
    func socialLogin(withToken token: String, onSuccess: @escaping SuccessBlock<User>, onError: @escaping ErrorBlock) {
        
        runInBackground { [weak self] in
            
            self?.facebookService.loginUser(withToken: token, onSuccess: { (user) in
                runOnUiThread {
                    onSuccess(user)
                }
            }, onError: { (error) in
                debugPrint(error)
                runOnUiThread {
                    onError(AuthErrors.socialLoginError)
                }
            })
        }
    }
    
    
    func registerUser(withName name: String, andPassword password: String, onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {
        
    }
    
}
