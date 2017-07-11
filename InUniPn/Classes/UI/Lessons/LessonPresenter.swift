//
//  LessonPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import EventKit

struct LessonToDisplay {
    var id : String
    var name : String
    var teacher : String
    var startTime : String
    var endTime: String
    var course : String
    var classroom : String
    
    var joined : Bool
    
    
    init(withId id: String, name:String, teacher:String, startTime:String, endTime:String, course:String, classroom:String, andJoined joined:Bool){
        self.id =  id 
        self.name = name 
        self.teacher =  teacher 
        self.startTime = startTime 
        self.endTime = endTime 
        self.course =  course 
        self.classroom =  classroom 
        self.joined =  joined 
    }
}

struct Day{
    var date : String
    var lessons : [LessonToDisplay]
}


class LessonPresenter: BasePresenter {
    
    //MARK: - variables
    
    private var user : User?
    private(set) var days : [Day] = []
    
    
    //MARK: - services
    
    private var showProgress = true

    private let userService : UserService = UserService()
    private var lessonService : LessonsService?
    private var universitiesService: UniversitiesServices?
    private var lessonList: [Lesson] = []
    private var universities: [University] = []
    private var currentUniversity: University?
    
    //MARK: - view
    
    private var lessonView : LessonView? 
    
    //MARK: - lifecycle methods
    
    func create(withView view: LessonView) {
        lessonView = view
        user = userService.currentUser()
        if let token = user?.accessToken{
            lessonService = LessonsService(withToken: token)
        } else {
            lessonView?.showError(withError: Strings.unknownError)
        }

        universitiesService = UniversitiesServices()
    }

    func start() {
        if showProgress {
            showProgress = false
            lessonView?.showProgress()
        }
        user = userService.currentUser()
        universitiesService?.all(onSuccess: onUniversities, onError: onUniversitiesError)
    }

    private func onUniversities(unis: [University]) {
        universities = unis
        if let index = universities.index(where: { u in u.code == user?.university }) {
            currentUniversity = universities[index]
            lessonView?.showUniversitiesForFilter(titles: unis.flatMap({ u in u.code }))
            lessonView?.showDefaultUniversity(atIndex: index)
            loadLessons()
        }
    }

    private func onUniversitiesError(error: Error) {
        lessonView?.hideProgress()
        lessonView?.showError(withError: Strings.unknownError)
    }
    
    //MARK: - user interaction methods
    
    
    func showJoiningChoice(withLesson lesson:Lesson) {
        lessonView?.displayJoiningChoice(isAlreadyJoined: lesson.joined)
    }

    func toggleJoinedStateOfLesson(byId id: String) {
        if let lesson = lessonList.first(where: { lesson in lesson.lessonId == id }) {
            if lesson.joined {
                unjoinLesson(byId: id)
            } else {
                joinLesson(byId: id)
            }
        }
    }

    func selectedUniversityAtIndex(index: Int) {
        currentUniversity = universities[index]
        loadLessons()
    }
    
    private func joinLesson(byId id: String) {
        lessonService?.joinLesson(byId: id, onSuccess: onSuccessfulJoinToggle, onError: onErrorJoining)
    }
    
    private func unjoinLesson(byId id: String) {
        lessonService?.unjoinLesson(byId: id, onSuccess: onSuccessfulJoinToggle, onError: onErrorJoining)
    }

    private func onSuccessfulJoinToggle(lesson: Lesson) {
        updateLessonView(lesson: lesson)
    }

    private func onErrorJoining(error: Error) {

    }

    private func updateLessonView(lesson: Lesson) {
        if let index = lessonList.index(where: { l in l.lessonId == lesson.lessonId }) {
            lessonList[index] = lesson
            days = rawLessonsToDays(withLessons: lessonList)
            
            if let indexPath = lessonInDays(lesson: lesson, days: days) {
                lessonView?.updateLessonView(days: days, atIndexPath: indexPath)
            } else {
                lessonView?.displayLessons(withLessonList: days)
            }

        }
    }

    private func lessonInDays(lesson: Lesson, days: [Day]) -> IndexPath? {
        for section in 0..<days.count {
            let lessons = days[section].lessons
            for row in 0..<lessons.count {
                let l = lessons[row]
                if l.id == lesson.lessonId {
                    return IndexPath(row: row, section: section)
                }
            }
        }
        return nil
    }

    func joinAllLessonRelated(toLesson lesson:Lesson){
        if let type = lesson.type{
            lessonService?.joinAllFutureLessons(ofType: type)
            lessonView?.showMessage(withMessage: Strings.joinedSuccessfully)
        } else {
            lessonView?.showError(withError: Strings.errorJoiningLessons)
        }
    }
    
    func unjoinAllLessonRelated(toLesson lesson:Lesson){
        if let type = lesson.type{
            lessonService?.unjoinAllFutureLessons(ofType: type)
            lessonView?.showMessage(withMessage: Strings.unjoinedSuccessfully)
            
        } else {
            lessonView?.showError(withError: Strings.errorJoiningLessons)
        }
    }
    
    func showNewsView(){
        lessonView?.navigateToNews()
    }
    
    func showProfile(){
        lessonView?.navigateToProfile()
    }
    
    func loadLessons(withQueryString queryString: String = "") {
        if queryString.isEmpty {
            lessonService?.all(fromDate: Date(), onSuccess: { (lessons) in
                let filteredLessons = lessons.filter({ l in
                    if let uni = l.course, let code = self.currentUniversity?.code {
                        return uni == code
                    } else {
                        return false
                    }
                })
                self.displayLessons(withLessons: filteredLessons)
            })
        } else {
            lessonService?.searchLessons(withKeyword: queryString, onSuccess: displayLessons)
        }
    }
    
    //MARK: - private methods
    
    func displayLessons(withLessons lessons : [Lesson]) {
        self.lessonList = lessons

        days = rawLessonsToDays(withLessons: lessons)

        lessonView?.hideProgress()
        lessonView?.displayLessons(withLessonList: days)
    }
}
