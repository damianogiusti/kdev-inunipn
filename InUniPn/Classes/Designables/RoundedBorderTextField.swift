//
//  RoundedBorderTextField.swift
//  InUniPn
//
//  Created by Mattia Contin  on 26/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedBorderTextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        updateBorder()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var bordered: Bool = false {
        didSet {
            updateBorder()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    
    func updateBorder() {
        if bordered {
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
        }
    }
}
