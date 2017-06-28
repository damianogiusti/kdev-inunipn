//
//  Lesson.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class Lesson {

    var lessonId: String
    var name: String?
    var teacher: String?
    var classroom: String?
    var date: Date?
    var timeStart: Date?
    var timeEnd: Date?
    var course: String?
    var type: String?
    var area: Int?

    var joined: Bool = false

    init(withId lessonId: String) {
        self.lessonId = lessonId
    }

}
