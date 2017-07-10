//
//  LessonsRealmDatasource.swift
//  InUniPn
//
//  Created by Damiano Giusti on 10/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class LessonsRealmDatasource: BaseRealmDatasource {

    typealias DM = DMLesson
    typealias M = Lesson

    func mapToDataModel(model: Lesson?) -> DMLesson? {
        if let lesson = model {
            let realmLesson = DMLesson(withId: lesson.lessonId)
            realmLesson.name = lesson.name
            realmLesson.teacher = lesson.teacher
            realmLesson.classroom = lesson.classroom
            realmLesson.course = lesson.course
            realmLesson.date = lesson.date
            realmLesson.timeStart = lesson.timeStart
            realmLesson.timeEnd = lesson.timeEnd
            realmLesson.joined = lesson.joined
            realmLesson.area = lesson.area ?? 0
            return realmLesson
        } else {
            return nil
        }
    }

    func mapToModel(dataModel: DMLesson?) -> Lesson? {

        if let realmLesson = dataModel {
            let lesson = Lesson(withId: realmLesson.lessonId)
            lesson.name = realmLesson.name
            lesson.teacher = realmLesson.teacher
            lesson.classroom = realmLesson.classroom
            lesson.course = realmLesson.course
            lesson.date = realmLesson.date
            lesson.timeStart = realmLesson.timeStart
            lesson.timeEnd = realmLesson.timeEnd
            lesson.joined = realmLesson.joined
            lesson.area = realmLesson.area
            return lesson
        } else {
            return nil
        }
    }
}
