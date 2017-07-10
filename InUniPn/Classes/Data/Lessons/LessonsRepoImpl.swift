//
//  LessonsRepoImpl.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class LessonsRepoImpl: LessonsRepository {

    private static var allLessonCallsCount = 0

    private let token: String

    private let storageDatasource: LessonsRealmDatasource
    private let restDatasource: LessonsRestDatasource

    required init(withToken token: String) {
        self.token = token
        self.storageDatasource = LessonsRealmDatasource()
        self.restDatasource = LessonsRestDatasource(withToken: token)
    }

    func lesson(byId id: String) -> Lesson? {
        return storageDatasource.obj(byId: id)
    }

    func all() -> [Lesson] {
        // the first time always call the REST API
        if LessonsRepoImpl.allLessonCallsCount == 0 {
            LessonsRepoImpl.allLessonCallsCount += 1

            if let lessons: [Lesson] = restDatasource.all().data {
                let persistedLessons: [Lesson] = storageDatasource.all()

                // if some data is persisted, recover the starred state
                // and apply it to the retrieved data
                if !persistedLessons.isEmpty {
                    lessons.forEach({ l in
                        l.joined = persistedLessons.filter({ pl in pl.lessonId == l.lessonId }).first?.joined ?? false
                    })
                }

                // update the persisted data with the REST one
                storageDatasource.saveAll(objects: lessons)
                return lessons
            } else {
                return []
            }
        }
            // the second time check if some data is persisted,
            // else get the REST api call result, save it, and return it
        else {
            let newss = storageDatasource.all()
            if !newss.isEmpty {
                return newss
            } else {
                if let news = restDatasource.all().data {
                    storageDatasource.saveAll(objects: news)
                    return news
                }
                return []
            }
        }
    }

    func save(lesson: Lesson) -> Bool {
        if storageDatasource.save(obj: lesson) /* && others */ {
            return true
        } else {
            return false
        }
    }

    func saveAll(lessons: [Lesson]) -> Bool {
        return storageDatasource.saveAll(objects: lessons)
    }

    func delete(byId id: String) -> Bool {
        return storageDatasource.delete(byId: id)
    }
}
