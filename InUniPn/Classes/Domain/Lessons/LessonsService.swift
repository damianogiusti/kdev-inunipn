//
//  LessonsService.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

enum LessonsErrors: Error {
    case lessonNotExisting, errorJoiningMultipleLessons, errorDeletingLesson
}

class LessonsService: BaseService {

    private let token: String
    private let lessonsRepository: LessonsRepository

    init(withToken token: String) {
        self.token = token
        self.lessonsRepository = RepositoryFactory.lessonsRepository(withToken: token)
    }

    /// Gets all lessons
    func all(onSuccess: @escaping SuccessBlock<[Lesson]>, onError: ErrorBlock? = nil) {
        runInBackground {
            let lessons = self.lessonsRepository.all().sorted(by: self.sortByDateDesc)
            runOnUiThread {
                onSuccess(lessons)
            }
        }
    }

    /// Gets a lesson by a given ID
    func lesson(byId id: String, onSuccess: @escaping SuccessBlock<Lesson>, onError: @escaping ErrorBlock) {
        runInBackground {

            if let lesson = self.lessonsRepository.lesson(byId: id) {
                runOnUiThread {
                    onSuccess(lesson)
                }
            } else {
                runOnUiThread {
                    onError(LessonsErrors.lessonNotExisting)
                }
            }
        }
    }

    /// Deletes a lesson by a given ID
    func deleteLesson(byId id: String, onSuccess: @escaping SuccessBlock<Void>, onError: @escaping ErrorBlock) {
        runInBackground {

            if self.lessonsRepository.delete(byId: id) {
                runOnUiThread {
                    onSuccess()
                }
            } else {
                runOnUiThread {
                    onError(LessonsErrors.errorDeletingLesson)
                }
            }
        }
    }

    /// Joins a lesson
    func joinLesson(byId lessonId: String, onSuccess: SuccessBlock<Lesson>? = nil, onError: ErrorBlock? = nil) {
        self.markLesson(byId: lessonId, asJoined: true, onSuccess: { lesson in
            LessonNotificationManager.scheduleNotification(forLesson: lesson)
            onSuccess?(lesson)
        }, onError: onError)
    }


    /// Unjoins a lesson
    func unjoinLesson(byId lessonId: String, onSuccess: SuccessBlock<Lesson>? = nil, onError: ErrorBlock? = nil) {
        self.markLesson(byId: lessonId, asJoined: false, onSuccess: { lesson in
            LessonNotificationManager.removeScheduledNotification(forLessonId: lesson.lessonId)
            onSuccess?(lesson)
        }, onError: onError)
    }

    /// Joins all the future lessons of this type
    func joinAllFutureLessons(ofType lessonType: String, onSuccess: SuccessBlock<[Lesson]>? = nil, onError: ErrorBlock? = nil) {
        runInBackground {

            let newlyJoinedLessons = self.markLessons(withType: lessonType, asJoined: true)

            if self.lessonsRepository.saveAll(lessons: newlyJoinedLessons) {
                runOnUiThread {
                    onSuccess?(newlyJoinedLessons)
                }
            } else {
                runOnUiThread {
                    onError?(LessonsErrors.errorJoiningMultipleLessons)
                }
            }
        }
    }

    /// Unjoins all the future lessons of this type
    func unjoinAllFutureLessons(ofType lessonType: String, onSuccess: SuccessBlock<[Lesson]>? = nil, onError: ErrorBlock? = nil) {
        runInBackground {

            let newlyJoinedLessons = self.markLessons(withType: lessonType, asJoined: false)

            if self.lessonsRepository.saveAll(lessons: newlyJoinedLessons) {
                runOnUiThread {
                    onSuccess?(newlyJoinedLessons)
                }
            } else {
                runOnUiThread {
                    onError?(LessonsErrors.errorJoiningMultipleLessons)
                }
            }
        }
    }

    /// Search all lessons for name, classroom and teacher
    func searchLessons(withKeyword keyword: String, onSuccess: @escaping SuccessBlock<[Lesson]>) {
        let lowercasedQuery = keyword.lowercased()
        runInBackground {

            let currentDate = Date()
            let lessons = self.lessonsRepository.all().filter({ lesson in
                if let startDate = lesson.timeEnd, startDate >= currentDate &&
                    (lesson.name?.lowercased().range(of: lowercasedQuery) != nil ||
                    lesson.classroom?.trim().lowercased().range(of: lowercasedQuery) != nil ||
                    lesson.teacher?.trim().lowercased().range(of: lowercasedQuery) != nil) {
                    return true
                }
                return false
            })

            runOnUiThread {
                onSuccess(lessons)
            }
        }
    }

    /// Gets all the joined lessons
    func allJoinedLessons(fromDate date: Date? = nil, onSuccess: @escaping SuccessBlock<[Lesson]>, onError: ErrorBlock? = nil) {

        runInBackground {

            let lessons: [Lesson] = self.lessonsRepository.all()
                .filter({ lesson in
                    var filter = lesson.joined
                    if let startDate = date, let lessonStartDate = lesson.timeStart {
                        filter = filter && lessonStartDate >= startDate
                    }
                    return filter
                })

            runOnUiThread {
                onSuccess(lessons)
            }
        }
    }

    private func markLessons(withType lessonType: String, asJoined joined: Bool) -> [Lesson] {
        let currentDate = Date()
        return self.lessonsRepository.all().filter({ lesson in
            if let startDate = lesson.timeStart, let type = lesson.type {
                return startDate >= currentDate && type == lessonType
            }
            return false
        }).map({ lesson in
            lesson.joined = joined
            return lesson
        })

    }

    private func markLesson(byId lessonId: String, asJoined joined: Bool, onSuccess: SuccessBlock<Lesson>?, onError: ErrorBlock?) {
        runInBackground {
            if let lesson = self.lessonsRepository.lesson(byId: lessonId) {
                if lesson.joined != joined {
                    lesson.joined = joined
                    if self.lessonsRepository.save(lesson: lesson) {
                        runOnUiThread {
                            onSuccess?(lesson)
                        }
                    }
                }
            } else {
                runOnUiThread {
                    onError?(LessonsErrors.lessonNotExisting)
                }
            }
        }
    }

    private func sortByDateDesc(lesson1: Lesson?, lesson2: Lesson?) -> Bool {
        if let d1 = lesson1?.date, let d2 = lesson2?.date {
            return d1 > d2
        } else {
            return false
        }
    }

}
