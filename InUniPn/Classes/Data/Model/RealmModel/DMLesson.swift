//
//  DMLesson.swift
//  InUniPn
//
//  Created by Damiano Giusti on 10/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import RealmSwift

class DMLesson: Object {

    dynamic var lessonId: String = UUID().uuidString
    dynamic var name: String?
    dynamic var teacher: String?
    dynamic var classroom: String?
    dynamic var date: Date?
    dynamic var timeStart: Date?
    dynamic var timeEnd: Date?
    dynamic var course: String?
    dynamic var type: String?
    dynamic var area: Int = 0

    var joined: Bool = false

    convenience init(withId lessonId: String) {
        self.init()
        self.lessonId = lessonId
    }
}
