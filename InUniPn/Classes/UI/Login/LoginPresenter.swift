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
        // authManager.socialLogin(withToken: token, onSuccess: onLoginSuccess, onError: onLoginError)
    }
    
    func registerUser() {
        loginView?.navigateToRegistration()
    }
    
    
    //MARK: - private methods
    
    private func onLoginSuccess(_ : Any){
        loginView?.navigateToHome()
    }
    
    private func onLoginError(_ : Any){
        loginView?.showError(withError: "Errore nel login, riprovare tra qualche moemnto")
    }
    
    private func onCredentialsAreInvalid(){
        loginView?.showError(withError: "Compilare tutti i campi")
    }
    
}
