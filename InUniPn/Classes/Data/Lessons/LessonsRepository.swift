//
//  LessonRepository.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

protocol LessonsRepository: class {

    init(withToken token: String)

    func lesson(byId id: String) -> Lesson?

    func all() -> [Lesson]

    func save(lesson: Lesson) -> Bool

    func delete(byId id: String) -> Bool

}
