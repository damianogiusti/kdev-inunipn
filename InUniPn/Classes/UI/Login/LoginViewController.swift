//
//  LoginViewController.swift
//  InUniPn
//
//  Created by Mattia Contin  on 26/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!

    private let loginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginPresenter.create(view: self)
        
        setupInputs()
    }
    
    // Colors placeholder strings with semi-transparent white
    private func setupInputs() {
        var tempStr = NSAttributedString(string: "esempio@unipn.it", attributes: [NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.6)])
        inputEmail.attributedPlaceholder = tempStr
        
        tempStr = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.6)])
        inputPassword.attributedPlaceholder = tempStr
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
        let email = inputEmail.text ?? ""
        let password = inputPassword.text ?? ""
        
        loginPresenter.loginUser(withName: email, andPassword: password)
    }

    @IBAction func didPressFacebook(_ sender: Any) {
        loginPresenter.loginUserWithFacebook(withName: "", andPassword: "")
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
        
    }
    
    func showError(withError error: String) {
        displayError(withMessage: error)
    }
    
    func showMessage(withMessage message: String) {
        displayAlert(withMessage: message)
    }
}
