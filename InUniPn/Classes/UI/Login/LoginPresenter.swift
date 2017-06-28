//
//  LoginPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class LoginPresenter: BasePresenter {


    //MARK: - services

    private var authManager : AuthenticationManager = AuthenticationManager()

    private let userService : UserService = UserService()

    //MARK: - view


    private var loginView : LoginView?

    //MARK: - lifecycle methods


    func create(withView view: LoginView) {
        loginView = view
    }

    //MARK: - user interaction methods

    func loginUser(withName name: String, andPassword password: String) {

        if(name.isEmpty || password.isEmpty){
            onCredentialsAreInvalid()
        }
        else{
            authManager.loginUser(
                withName: name,
                andPassword: password,
                onSuccess: onLoginSuccess,
                onError: onLoginError
            )
        }
    }

    func loginUserWithFacebook(withToken token: String) {
         authManager.socialLogin(withToken: token, onSuccess: onSocialLoginSuccess, onError: onLoginError)
    }

    func registerUser() {
        loginView?.navigateToRegistration()
    }

    func setUniversity(withName name : String){
        if(name.isEmpty){
            loginView?.askUniversity(withError: Strings.fillAllFields)
        }
        else{
           //user_addUniversity
        }
    }

    //MARK: - private methods

    private func onSocialLoginSuccess(_ : Any){
        loginView?.askUniversity(withError: nil)
    }

    func onLoginSuccess(_ : Any){
        loginView?.navigateToHome()
    }


    private func onLoginError(_ : Any){
        loginView?.showError(withError: Strings.errorWhileLogginIn)
    }

    private func onCredentialsAreInvalid(){
        loginView?.showError(withError: Strings.fillAllFields)
    }

}
