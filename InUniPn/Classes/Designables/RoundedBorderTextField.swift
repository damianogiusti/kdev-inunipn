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
    
    private var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
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
    
    @IBInspectable var horizontalPadding: CGFloat = 10 {
        didSet {
            updatePadding()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        updateBorder()
        updatePadding()
    }
    
    func updatePadding() {
        padding = UIEdgeInsets(top: 0, left: horizontalPadding, bottom: 0, right: horizontalPadding)
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
