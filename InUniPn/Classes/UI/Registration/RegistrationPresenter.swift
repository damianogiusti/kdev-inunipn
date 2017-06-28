//
//  RegistrationPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class RegistrationPresenter: BasePresenter {
    
    //MARK: - variables
    
    private var authManager : AuthenticationManager = AuthenticationManager()
    
    private var registrationView : RegistrationView? 
    
    //MARK: - lifecycle methods
    
    func create(withView view: RegistrationView) {
        registrationView = view
    }
    
    //MARK: - user interaction methods
    
    func registerUser(withName name: String,
                      andEmail email: String, 
                      andPassword password: String,
                      andConfirmationPassword confirmationPassword: String,
                      andUniversity university: String) {
        
        if(credentialsAreValid(withName: name, 
                               andEmail: email,
                               andPassword: password, 
                               andConfirmationPassword: confirmationPassword,
                               andUniversity: university)){
            
            authManager.registerUser(withName: name, 
                                     andPassword: password, 
                                     onSuccess: onRegistrationSuccess, 
                                     onError: onRegistrationError)
        }
        else{
            onCredentialsAreInvalid()
        }
    }
    
    func returnToLogin(){
        registrationView?.navigateToLogin()
    }
    
    //MARK: - private methods
    
    private func onRegistrationSuccess(_ : Any){
        registrationView?.navigateToHome()
    }
    
    private func onRegistrationError(_ : Any){
        registrationView?.showError(withError: Strings.errorWhileSigninUp)
    }
    
    private func onCredentialsAreInvalid(){
        registrationView?.showError(withError: Strings.fillAllFields)
    }
    
    private func credentialsAreValid(withName name: String,
                                     andEmail email: String, 
                                     andPassword password: String,
                                     andConfirmationPassword confirmationPassword: String,
                                     andUniversity university: String) -> Bool{
        
        return !(name.isEmpty || password.isEmpty || confirmationPassword.isEmpty || university.isEmpty)
    }
}
