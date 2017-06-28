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
        var tempStr = NSAttributedString(string: "esempio@unipn.it", attributes: [NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.6)])
        inputEmail.attributedPlaceholder = tempStr
        
        tempStr = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.6)])
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
                if fbloginresult.grantedPermissions.contains("email") {
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
        let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        
        present(homeController, animated: true, completion: nil)
    }
    
    func showError(withError error: String) {
        displayError(withMessage: error)
    }
    
    func showMessage(withMessage message: String) {
        displayAlert(withMessage: message)
    }
    
    func askUniversity(withUniversities universities : [University]) {
        let unis = [University]()
        
        let sheet = UIAlertController(title: Strings.university, message: Strings.pickUniversity, preferredStyle: .actionSheet)
        
        unis.forEach { uni in
            sheet.addAction(UIAlertAction(title: uni.code, style: .default, handler: { view in
                self.navigateToHome()
            }))
        }
        
        sheet.addAction(UIAlertAction(title: "placeholder", style: .default, handler: { view in
            self.navigateToHome()
        }))
        
        present(sheet, animated: true, completion: nil)
    }
    
}
