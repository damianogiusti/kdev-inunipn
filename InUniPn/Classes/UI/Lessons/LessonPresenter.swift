//
//  LessonPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import EventKit

struct LessonToDisplay{
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
    
    //MARK: - services
    
    //    private var newsService
    
    private let userService : UserService = UserService()
    private var lessonService : LessonsService?
    
    //MARK: - view
    
    private var lessonView : LessonView? 
    
    //MARK: - lifecycle methods
    
    func create(withView view: LessonView) {
        lessonView = view
        user = userService.currentUser()
        if let token = user?.accessToken{
            lessonService = LessonsService(withToken : token);
        } else {
            lessonView?.showError(withError: Strings.unknownError)
        }
    }
    
    //MARK: - user interaction methods
    
    
    func addEventToCalendar(title: String, description: String?, classroom: String?, date day: String, startTime: String, endTime: String) {
        let eventStore = EKEventStore()
        
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = self.calculateDateTime(withDate: day, andTime: startTime)
                event.endDate = self.calculateDateTime(withDate: day, andTime: endTime)
                event.notes = description
                event.location = classroom
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    self.lessonView?.showError(withError: "Errore nel salvataggio \(e)")                                   
                }
                self.lessonView?.showMessage(withMessage: "Evento Aggiunto da \(event.startDate) a \(event.endDate)")
            } else {
                self.lessonView?.showError(withError: "Non mi hai dato i permessi")                                   
            }
        })
    }
    
    
    func showJoiningChoice(withLesson lesson:Lesson){
        lessonView?.displayJoiningChoice(isAlreadyJoined: lesson.joined)
    }
    
    func joinLesson(withLesson lesson:Lesson){
        lessonService?.joinLesson(byId: lesson.lessonId)
        lessonView?.showMessage(withMessage: Strings.joinedSuccessfully)
        
    }
    
    func unjoinLesson(withLesson lesson:Lesson){
        lessonService?.unjoinLesson(byId: lesson.lessonId)
        lessonView?.showMessage(withMessage: Strings.unjoinedSuccessfully)
        
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
    
    func loadLessons(withQueryString queryString: String?=nil){
        
        if let string = queryString{
            lessonService?.searchLessons(withKeyword: string, onSuccess: displayLessons)  
        } else {
            lessonService?.all(onSuccess: displayLessons)
        }
    }
    
    //MARK: - private methods
    
    func displayLessons(withLessons lessons : [Lesson]){
        
        var formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        
        
        var tempLessons: [String: [Lesson]] = lessons.categorise({ l in formatter.string(from: l.date ?? Date()) }) 
        
        formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        
        var lessonsToDisplay : [String: [LessonToDisplay]] = [:]
        
        
        for key in tempLessons.keys {
            let v : [LessonToDisplay] =  (tempLessons[key]?.flatMap({ (l: Lesson) in LessonToDisplay(withId: l.lessonId, 
                                                                                                     name: l.name ?? "", 
                                                                                                     teacher: l.teacher ?? "", 
                                                                                                     startTime: formatter.string(from: l.timeStart ?? Date()), 
                                                                                                     endTime: formatter.string(from: l.timeEnd ?? Date()), 
                                                                                                     course: l.course ?? "", 
                                                                                                     classroom: l.classroom ?? "", 
                                                                                                     andJoined: l.joined) }))!
            
            lessonsToDisplay[key] = v
        } 
        
        
        var days : [Day] = []
        
        for (key, value) in lessonsToDisplay {
            days.append(Day(date : key, lessons : value.sorted(by: sortForLesson)))
        }
        
        days.sort(by: sortForDays)
        
        
        
        lessonView?.displayLessons(withLessonList: days)
    }
    
    func sortForDays(this:Day, that:Day) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.date(from :this.date)! < formatter.date(from :that.date)!
    }
    
    func sortForLesson(this:LessonToDisplay, that:LessonToDisplay) -> Bool {
        
        return this.classroom < that.classroom
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
