//
//  News.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class News {
    
    let newsId: String
    
    var title: String?
    var content: String?
    var createdDate: Date?
    var updatedDate: Date?
    var imageUrl: String?
    var link: String?

    var page: Int = 0

    var starred: Bool = false
    
    init(withId id: String) {
        self.newsId = id
    }
}
