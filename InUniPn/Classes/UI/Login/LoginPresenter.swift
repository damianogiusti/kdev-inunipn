//
//  LoginPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class LoginPresenter: BasePresenter {

    //MARK: - variables

    private var authManager : AuthenticationManager = AuthenticationManager()

    private var loginView : LoginView?

    //MARK: - overrided methods

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
       //  authManager.socialLogin(withToken: token, onSuccess: onSocialLoginSuccess, onError: onLoginError)
    }

    func registerUser() {
        loginView?.navigateToRegistration()
    }



    func setUniversity(withName name : String){
        if(name.isEmpty){
            loginView?.askUniversity(withError: "Compila il campo")
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

    func onLoginError(_ : Any){
        loginView?.showError(withError: "Errore nel login, riprovare tra qualche momento")
    }

    private func onCredentialsAreInvalid(){
        loginView?.showError(withError: "Compilare tutti i campi")
    }

}
