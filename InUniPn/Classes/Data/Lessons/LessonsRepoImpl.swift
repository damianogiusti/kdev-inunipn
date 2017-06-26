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
    private let memoryDatasource: LessonsInMemoryDatasource
    private let restDatasource: LessonsRestDatasource

    required init(withToken token: String) {
        self.token = token
        self.memoryDatasource = LessonsInMemoryDatasource()
        self.restDatasource = LessonsRestDatasource(withToken: token)
    }

    func lesson(byId id: String) -> Lesson? {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.lesson(byId: id)
        } else {
            memoryDatasource.renew()
            fatalError("not implemented")
        }
    }

    func all() -> [Lesson] {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.all()
        } else {
            memoryDatasource.renew()
            fatalError("not implemented")
        }
    }

    func save(lesson: Lesson) -> Bool {
        if memoryDatasource.isExpired() {
            // renew and fetch data
            memoryDatasource.renew()
        }

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
