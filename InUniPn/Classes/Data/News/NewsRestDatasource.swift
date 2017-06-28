//
//  NewsRestDatasource.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsRestDatasource {
    private let token: String
    
    init(withToken token: String) {
        self.token = token
    }
    
    func all() -> [News] {
        return []
    }
}
