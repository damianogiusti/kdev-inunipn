//
//  LoginViewController.swift
//  InUniPn
//
//  Created by Mattia Contin  on 26/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, LoginView {
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    
    private let loginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginPresenter.create(withView: self)
        
        setupInputs()
    }
    
    // Colors placeholder strings with semi-transparent white
    private func setupInputs() {
        var tempStr = NSAttributedString(string: Strings.emailPlaceholder, attributes: [NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.6)])
        inputEmail.attributedPlaceholder = tempStr
        
        tempStr = NSAttributedString(string: Strings.password, attributes: [NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.6)])
        inputPassword.attributedPlaceholder = tempStr
    }
    
    private func getFBUserData(){
        if let token = FBSDKAccessToken.current() {
            self.loginPresenter.loginUserWithFacebook(withToken: token.tokenString)
        }
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
        let email = inputEmail.text ?? ""
        let password = inputPassword.text ?? ""
        
        loginPresenter.loginUser(withName: email, andPassword: password)
    }
    
    @IBAction func didPressFacebook(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error == nil {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions?.contains("email") ?? false {
                    self.getFBUserData()
                }
            } else {
                debugPrint(error!.localizedDescription)
                self.showError(withError: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func didPressRegistration(_ sender: Any) {
        loginPresenter.registerUser()
    }
    
    func navigateToRegistration() {
        let modalViewController = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        modalViewController.modalPresentationStyle = .overCurrentContext
        present(modalViewController, animated: true, completion: nil)
    }
    
    func navigateToHome() {
//        if let homeController = appDelegate.mainStoryboard?.instantiateInitialViewController() {
//            present(homeController, animated: true, completion: nil)
//        }
        appDelegate.navigateToHome()
    }

    func showProgress() {
        showProgressDialog(onView: self.view, withMessage: Strings.loading)
    }

    func showProgressForSocialLogin() {
        showProgressDialog(onView: self.view, withMessage: Strings.contactingFacebook)
    }

    func hideProgress() {
        hideProgressDialog()
    }
    
    func showError(withError error: String) {
        displayError(withMessage: error)
    }
    
    func showMessage(withMessage message: String) {
        displayAlert(withMessage: message)
    }
    
    func askUniversity(withUniversities universities : [University]) {
        
        let sheet = UIAlertController(title: Strings.university, message: Strings.pickUniversity, preferredStyle: .actionSheet)
        
        universities.forEach { uni in
            sheet.addAction(UIAlertAction(title: uni.code, style: .default, handler: { (view: UIAlertAction) in
                self.loginPresenter.setUniversity(withName: view.title ?? "")
            }))
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
}
