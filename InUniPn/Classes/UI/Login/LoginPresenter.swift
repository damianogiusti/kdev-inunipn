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


    private weak var loginView : LoginView?

    //MARK: - lifecycle methods


    func create(withView view: LoginView) {
        loginView = view
    }

    //MARK: - user interaction methods

    func loginUser(withEmail email: String, andPassword password: String) {

        if (email.isEmpty || password.isEmpty) {
            onCredentialsAreInvalid()
        } else {
            authManager.loginUser(
                withEmail: email,
                andPassword: password,
                onSuccess: onLoginSuccess,
                onError: onLoginError
            )
            loginView?.showProgress()
        }
    }

    func loginUserWithFacebook(withToken token: String) {
         authManager.socialLogin(withToken: token, onSuccess: onSocialLoginSuccess, onError: onLoginError)
        loginView?.showProgressForSocialLogin()
    }

    func registerUser() {
        loginView?.navigateToRegistration()
    }

    func setUniversity(withName name : String) {
        if (name.isEmpty) {
             universityService.all(onSuccess: askUniversity, onError: onErrorRetrievingUniversities)
        } else {
            if let user = userService.currentUser() {
                user.university = name
                userService.save(user: user)
            }
            loginView?.navigateToHome()
        }
    }

    //MARK: - private methods

    private func onSocialLoginSuccess(_ : Any) {
        universityService.all(onSuccess: askUniversity, onError: onErrorRetrievingUniversities)
    }

    func onLoginSuccess(user : User) {
        universityService.all(onSuccess: askUniversity, onError: onErrorRetrievingUniversities)
    }


    private func onLoginError(_ : Any) {
        loginView?.hideProgress()
        loginView?.showError(withError: Strings.errorWhileLogginIn)
    }

    private func onCredentialsAreInvalid() {
        loginView?.hideProgress()
        loginView?.showError(withError: Strings.fillAllFields)
    }
    
    private func askUniversity(withUniversities universities: [University]) {
        loginView?.hideProgress()
        loginView?.askUniversity(withUniversities: universities)
    }
    
    private func onErrorRetrievingUniversities(error : Any){
        loginView?.hideProgress()
        loginView?.showError(withError: Strings.errorRetrievingUniveristies)
    }

}
