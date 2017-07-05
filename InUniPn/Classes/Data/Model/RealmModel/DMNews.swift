//
//  DMNews.swift
//  InUniPn
//
//  Created by Damiano Giusti on 04/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import RealmSwift

class DMNews: Object {

    dynamic var newsId: String = UUID().uuidString

    dynamic var title: String?
    dynamic var content: String?
    dynamic var createdDate: Date?
    dynamic var updatedDate: Date?
    dynamic var imageUrl: String?
    dynamic var link: String?

    dynamic var page: Int = 0

    dynamic var starred: Bool = false

    convenience init(withId id: String) {
        self.init()
        self.newsId = id
    }

    override class func primaryKey() -> String {
        return "newsId"
    }

}
