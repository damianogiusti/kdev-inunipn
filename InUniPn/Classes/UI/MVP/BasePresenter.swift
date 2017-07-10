//
//  BasePresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import CryptoSwift

class BasePresenter {

    private let baseGravatarUrl = "https://www.gravatar.com/avatar/%@?d=mm&s=200"

    func gravatarUrl(forEmail email: String) -> String {
        let hash: String = email.md5()
        return String(format: baseGravatarUrl, arguments: [hash])
    }
    
    
    
    func rawLessonsToDays(withLessons lessons: [Lesson])-> [Day]{
        
        var formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        var categorizedLessons: [String: [Lesson]] = lessons.categorise({ l in formatter.string(from: l.date ?? Date()) }) 
        
        formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        
        var rawDays : [String: [LessonToDisplay]] = [:]
        
        for key in categorizedLessons.keys {
            let lessonsForDay : [LessonToDisplay] =  (categorizedLessons[key]?.flatMap({ (l: Lesson) in LessonToDisplay(withId: l.lessonId,
                                                                                                     name: l.name ?? "", 
                                                                                                     teacher: l.teacher ?? "", 
                                                                                                     startTime: formatter.string(from: l.timeStart ?? Date()), 
                                                                                                     endTime: formatter.string(from: l.timeEnd ?? Date()), 
                                                                                                     course: l.course ?? "", 
                                                                                                     classroom: l.classroom ?? "", 
                                                                                                     andJoined: l.joined) }))!
            
            rawDays[key] = lessonsForDay
        } 
        
        var days : [Day] = []
        for (key, value) in rawDays {
            days.append(Day(date : key, lessons : value.sorted(by: sortForLesson)))
        }
        days.sort(by: sortForDays)
        return days
    }
    
    func sortForDays(this:Day, that:Day) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.date(from :this.date)! < formatter.date(from :that.date)!
    }
    
    func sortForLesson(this:LessonToDisplay, that:LessonToDisplay) -> Bool {
        
        return this.classroom < that.classroom
    }
}
