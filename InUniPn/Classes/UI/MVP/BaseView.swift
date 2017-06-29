//
//  BaseView.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol BaseView: class {
    
    func showError(withError error : String)
    
    func showMessage(withMessage message : String)

    func showProgress()

    func hideProgress()

}

extension BaseView {

    func showProgress() {

    }

    func hideProgress() {

    }
}
