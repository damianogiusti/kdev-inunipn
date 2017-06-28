//
//  LoginView.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol LoginView: BaseView {
    
    func navigateToRegistration()
    
    func navigateToHome()
    
    func askUniversity(withUniversities: [University])
}
