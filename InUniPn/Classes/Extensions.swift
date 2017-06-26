//
//  Extensions.swift
//  InUniPn
//
//  Created by Mattia Contin  on 26/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayError(withMessage message: String) {
        let alert = UIAlertController(title: "Errore", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func displayAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Attenzione", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
