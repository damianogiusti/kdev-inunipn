//
//  UIColor.swift
//  InUniPn
//
//  Created by Damiano Giusti on 29/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    static let fireBrickRed: UIColor = UIColor(rgb: 0xAD2222)

    static let lilyWhite: UIColor = UIColor(rgb: 0xEAEAEA)

    static let uniGrey: UIColor = UIColor(rgb: 0x808080)

}
