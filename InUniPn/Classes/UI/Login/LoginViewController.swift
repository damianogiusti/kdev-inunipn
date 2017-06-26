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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let email = inputEmail.text
        let password = inputPassword.text
        // tell the presenter the login was clicked
    }

    @IBAction func didPressFacebook(_ sender: Any) {
        // tell the login presenter the facebook button was clicked
    }

    @IBAction func didPressRegistration(_ sender: Any) {
        // tell the registration presenter the register button was clicked
    }
}
