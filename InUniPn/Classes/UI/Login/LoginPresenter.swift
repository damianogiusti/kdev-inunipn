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
    
    private let universityService : UniversitiesServices = UniversitiesServices()

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
             universityService.all(onSuccess: askUniversity, onError: onErrorRetrievingUniversities)
        }
        else{
           //user_addUniversity
        }
    }

    //MARK: - private methods

    private func onSocialLoginSuccess(_ : Any){
        universityService.all(onSuccess: askUniversity, onError: onErrorRetrievingUniversities)
        
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
    
    private func askUniversity(withUniversities universities: [University]){
        loginView?.askUniversity(withUniversities: universities)
    }
    
    private func onErrorRetrievingUniversities(error : Any){
         loginView?.showError(withError: Strings.errorRetrievingUniveristies)
    }

}
