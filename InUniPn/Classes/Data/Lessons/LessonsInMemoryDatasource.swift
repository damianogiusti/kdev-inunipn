//
//  LessonsInMemoryDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class LessonsInMemoryDatasource: LessonsRepository {

    private var dataset: [String:Lesson] = [:]

    private static let expirationTime: TimeInterval = 5 * 60 // 5 mins

    var expirationDate = Date()

    func lesson(byId id: String) -> Lesson? {
        return dataset[id]
    }


    func all() -> [Lesson] {
        return dataset.values.filter({ _ in true })
    }


    func save(lesson: Lesson) -> Bool {
        dataset[lesson.lessonId] = lesson
        return true
    }


    func delete(byId id: String) -> Bool {
        dataset[id] = nil
        return true
    }

    func isExpired() -> Bool {
        return expirationDate < Date()
    }

    func renew() {
        expirationDate = Date(timeIntervalSinceNow: LessonsInMemoryDatasource.expirationTime)
    }
}
