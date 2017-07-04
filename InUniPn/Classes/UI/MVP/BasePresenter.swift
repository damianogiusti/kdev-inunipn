//
//  BasePresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import CryptoSwift

class BasePresenter {

    private let baseGravatarUrl = "https://www.gravatar.com/avatar/%@?d=mm&s=200"

    func gravatarUrl(forEmail email: String) -> String {
        let hash: String = email.md5()
        return String(format: baseGravatarUrl, arguments: [hash])
    }
}
