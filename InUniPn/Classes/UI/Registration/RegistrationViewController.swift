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
    
    private var nameInput = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.text = Strings.name
            $0.textField.textAlignment = .right
            }.configure {
                $0.placeholder = Strings.namePlaceholder
        }
    private var emailInput = TextFieldRowFormer<FormTextFieldCell>() {
        $0.titleLabel.text = Strings.email
        $0.textField.textAlignment = .right
        $0.textField.keyboardType = .emailAddress
        
        }.configure {
            $0.placeholder = Strings.emailPlaceholder
    }
    private var passwordInput = TextFieldRowFormer<FormTextFieldCell>() {
        $0.titleLabel.text = Strings.password
        $0.textField.textAlignment = .right
        $0.textField.isSecureTextEntry = true
        }.configure {
            $0.placeholder = Strings.password
    }
    private var passwordConfirmInput = TextFieldRowFormer<FormTextFieldCell>() {
        $0.titleLabel.text = Strings.confirmPassword
        $0.textField.textAlignment = .right
        $0.textField.isSecureTextEntry = true
        }.configure {
            $0.placeholder = Strings.confirmPassword
    }
    private var universityPicker = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
        $0.titleLabel.text = Strings.university
        }.configure { row in
            row.pickerItems = (1...5).map {
                InlinePickerItem(title: "Option \($0)", value: Int($0))
            }
        }.onValueChanged { item in
            // Do Something
    }
    
    private let registrationPresenter = RegistrationPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        registrationPresenter.create(withView: self)
        setupForm()
        // Do any additional setup after loading the view.
    }
    
    private func setupForm() {
        let section = SectionFormer(rowFormer: nameInput, emailInput, passwordInput, passwordConfirmInput, universityPicker)
        former.append(sectionFormer: section)
    }
    
    // MARK: Navigation
    
    @IBAction func didPressBack(_ sender: Any) {
        registrationPresenter.returnToLogin()
    }
    
    @IBAction func didConfirmRegistration(_ sender: Any) {
        registrationPresenter.registerUser(withName: nameInput.text ?? "",
                                           andEmail: emailInput.text ?? "",
                                           andPassword: passwordInput.text ?? "",
                                           andConfirmationPassword: passwordConfirmInput.text ?? "",
                                           andUniversity: "")
    }
    
}

extension RegistrationViewController : RegistrationView {
    
    func navigateToHome() {
        let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        
        present(homeController, animated: true, completion: nil)
    }
    
    func navigateToLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onLoadedUniversities(withUniversities: [University]) {
        //TODO
    }
    
    func showError(withError error : String) {
        displayError(withMessage: error)
    }
    
    func showMessage(withMessage message : String) {
        displayAlert(withMessage: message)
    }

}
