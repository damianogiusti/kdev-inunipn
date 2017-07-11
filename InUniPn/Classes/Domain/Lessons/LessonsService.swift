//
//  LessonsService.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import EventKit

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
    func all(fromDate date: Date? = nil, onSuccess: @escaping SuccessBlock<[Lesson]>, onError: ErrorBlock? = nil) {
        runInBackground {
            var lessons = self.lessonsRepository.all().sorted(by: self.sortByDateAsc)

            // filter out lessons only if requested
            if let from = date {
                lessons = lessons.filter({ lesson in
                    if let endTime = lesson.timeEnd {
                        return endTime > from
                    } else {
                        return false
                    }
                })
            }
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
            if let title = lesson.name, let startTime = lesson.timeStart, let endTime = lesson.timeEnd {
                self.addEventToCalendar(title: title,
                                        description: lesson.course,
                                        classroom: lesson.classroom,
                                        startTime: startTime,
                                        endTime: endTime)
            }
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
                    if let startDate = date, let lessonEndDate = lesson.timeEnd {
                        filter = filter && lessonEndDate >= startDate
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

    private func sortByDateAsc(lesson1: Lesson?, lesson2: Lesson?) -> Bool {
        if let d1 = lesson1?.date, let d2 = lesson2?.date {
            return d1 > d2
        } else {
            return false
        }
    }

}


// MARK: - calendar extension


extension LessonsService {

    func addEventToCalendar(title: String, description: String?, classroom: String?, startTime: Date, endTime: Date) {
        let eventStore = EKEventStore()


        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startTime
                event.endDate = endTime
                event.notes = description
                event.location = classroom
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    print(e)
                }
            }
        })
    }

    func calculateDateTime(withDate date: String, andTime time: String) -> Date{

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let date : Date = formatter.date(from: date)!

        formatter.dateFormat = "HH:mm"

        let timeOfTheDay = formatter.date(from: time)

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let dateComponents = calendar.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: timeOfTheDay!)

        let hours = dateComponents.hour
        let minutes = dateComponents.minute

        var dateTime = calendar.date(byAdding: .minute, value: minutes!, to: date)
        dateTime = calendar.date(byAdding: .hour, value: hours!, to: dateTime!)

        return dateTime!
    }
}
