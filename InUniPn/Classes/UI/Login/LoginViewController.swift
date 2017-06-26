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
        
        var str = NSAttributedString(string: "esempio@unipn.it", attributes: [NSForegroundColorAttributeName:UIColor.gray])
        inputEmail.attributedPlaceholder = str
        
        str = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.gray])
        inputEmail.attributedPlaceholder = str
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
    }

    @IBAction func didPressFacebook(_ sender: Any) {
    }

}
