//
//  LessonsRepoImpl.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class LessonsRepoImpl: LessonsRepository {

    private let token: String
    private let memoryDatasource = LessonsInMemoryDatasource.sharedInstance
    private let restDatasource: LessonsRestDatasource

    required init(withToken token: String) {
        self.token = token
        self.restDatasource = LessonsRestDatasource(withToken: token)
    }

    func lesson(byId id: String) -> Lesson? {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.lesson(byId: id)
        } else {
            memoryDatasource.deleteAll()
            memoryDatasource.saveAll(lessons: restDatasource.all())
            memoryDatasource.renew()
            return memoryDatasource.lesson(byId: id)
        }
    }

    func all() -> [Lesson] {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.all()
        } else {
            let lessons = restDatasource.all()
            memoryDatasource.deleteAll()
            memoryDatasource.saveAll(lessons: lessons)
            memoryDatasource.renew()
            return lessons
        }
    }

    func save(lesson: Lesson) -> Bool {
        if memoryDatasource.save(lesson: lesson) /* && others */ {
            return true
        } else {
            return false
        }
    }

    func delete(byId id: String) -> Bool {
        return false
    }

}
