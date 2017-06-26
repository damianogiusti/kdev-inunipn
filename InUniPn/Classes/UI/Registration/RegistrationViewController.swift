//
//  RegistrationViewController.swift
//  InUniPn
//
//  Created by Mattia Contin  on 26/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import Former

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var former: Former = Former(tableView: self.tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        setupForm()
        // Do any additional setup after loading the view.
    }
    
    private func setupForm() {
        
        let nameInput = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.text = "Nome"
            $0.textField.textAlignment = .right
            }.configure {
                $0.placeholder = "Mario Rossi"
        }
        
        let emailInput = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.text = "Indirizzo email"
            $0.textField.textAlignment = .right
            }.configure {
                $0.placeholder = "example@unipn.it"
        }
        
        let passwordInput = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.text = "Password"
            $0.textField.textAlignment = .right
            $0.textField.isSecureTextEntry = true
            }.configure {
                $0.placeholder = "Password"
        }
        
        let passwordConfirmInput = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.text = "Conferma password"
            $0.textField.textAlignment = .right
            $0.textField.isSecureTextEntry = true
            }.configure {
                $0.placeholder = "Ripeti la password"
        }
        
        let universityPicker = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
            $0.titleLabel.text = "Università"
            }.configure { row in
                row.pickerItems = (1...5).map {
                    InlinePickerItem(title: "Option \($0)", value: Int($0))
                }
            }.onValueChanged { item in
                // Do Something
        }
        
        let section = SectionFormer(rowFormer: nameInput, emailInput, passwordInput, passwordConfirmInput, universityPicker)
        former.append(sectionFormer: section)
    }
    
    // MARK: Navigation
    
    @IBAction func didPressBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didConfirmRegistration(_ sender: Any) {
        // delegate data to the presenter
    }
}
