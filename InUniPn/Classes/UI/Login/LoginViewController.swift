//
//  LoginViewController.swift
//  InUniPn
//
//  Created by Mattia Contin  on 26/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
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
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"])
                .start(completionHandler: { (connection, result, error) -> Void in
                    if error == nil {
                        self.loginPresenter.loginUserWithFacebook(withToken: FBSDKAccessToken.current().tokenString)
                        //everything works print the user data
                        //                    print(result)
                    }
                })
        }
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
        let email = inputEmail.text ?? ""
        let password = inputPassword.text ?? ""
        
        loginPresenter.loginUser(withName: email, andPassword: password)
    }
    
    @IBAction func didPressFacebook(_ sender: Any) {
        FBSDKLoginManager()
            .logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
                if error == nil {
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    if fbloginresult.grantedPermissions.contains("email") {
                        self.getFBUserData()
                    }
                } else {
                    self.showError(withError: error!.localizedDescription)
                }
        }
    }
    
    @IBAction func didPressRegistration(_ sender: Any) {
        loginPresenter.registerUser()
    }
}

extension LoginViewController : LoginView {
    
    func navigateToRegistration() {
        let modalViewController = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        //let modalViewController = RegistrationViewController()
        modalViewController.modalPresentationStyle = .overCurrentContext
        present(modalViewController, animated: true, completion: nil)
    }
    
    func navigateToHome() {
        debugPrint("Congrats, you are supposed to be redirected to the home")
    }
    
    func showError(withError error: String) {
        displayError(withMessage: error)
    }
    
    func showMessage(withMessage message: String) {
        displayAlert(withMessage: message)
    }
    
    func askUniversity(withError: String?) {
        let sheet = UIAlertController(title: "Università", message: "Boh messaggio", preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: { view in
            sheet.dismiss(animated: true, completion: nil)
        }))
        
        sheet.addAction(UIAlertAction(title: "Uno", style: .default, handler: nil))
        
        present(sheet, animated: true, completion: nil)
    }
    
}
