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
    
    func create(view: LoginView) {
        loginView = view
    }
    
    //MARK: - user interaction methods
    
    func loginUser(withName name: String, andPassword password: String) {
        
        if(name.isEmpty || password.isEmpty){
            onCredentialsAreInvalid()
        }
        else{
            authManager.loginUser(
                usingSocial: false,
                withName: name, 
                andPassword: password, 
                onSuccess: onLoginSuccess, 
                onError: onLoginError
            )
        }
    }
    
    func loginUserWithFacebook(withName name: String, andPassword password: String) {
        authManager.loginUser(
            usingSocial: true,
            withName: name, 
            andPassword: password, 
            onSuccess: onLoginSuccess, 
            onError: onLoginError
        )    
    }
    
    func registerUser() {
        loginView?.navigateToRegistration()
    }
    
    func onLoginSuccess(_ : Any){
        loginView?.navigateToHome()
    }
    
    func onLoginError(_ : Any){
        loginView?.showError(withError: "Errore nel login, riprovare tra qualche momento")
    }
    
    func onCredentialsAreInvalid(){
        loginView?.showError(withError: "Completare tutti i campi")
    }
    
}
