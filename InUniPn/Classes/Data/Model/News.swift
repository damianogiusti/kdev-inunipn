//
//  News.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class News {
    
    let newsId:String
    
    var title: String?
    var content: String?
    var date: String?
    var image: String?
    var star: Bool = false
    
    init(withId id: String) {
        self.newsId = id
    }
}
