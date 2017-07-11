//
//  NotificationFactory.swift
//  InUniPn
//
//  Created by Mattia Contin  on 28/06/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import UserNotifications

class LessonNotificationManager {
    
    static func scheduleNotification(forLesson lesson: Lesson,
                                     onGranted: @escaping (() -> Void) = {},
                                     onError: @escaping ((Error) -> Void) = {_ in}) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                setNotification(forLesson: lesson)
                onGranted()
            } else if let error = error {
                onError(error)
            }
        }
    }

    static func removeScheduledNotification(forLessonId lessonId: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [lessonId])
    }
    
    private static func setNotification(forLesson lesson: Lesson) {
        if !NotificationPreferences.areNotificationsEnabled() {
            return
        }

        if let subject = lesson.name {
            if let lessonDate = lesson.timeStart {
                
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let hour = formatter.string(from: lessonDate)
                
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: subject, arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: "\(hour) - \(lesson.teacher ?? "")",
                    arguments: nil)
                
                let cal = Calendar.current
                
                let notificationDate = cal.date(byAdding: .minute, value: -(NotificationPreferences.getNotificationBeforeMinutes()), to: lessonDate) ?? Date()
                
                let dateInfo = cal.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
                
                // Create the request object.
                let request = UNNotificationRequest(identifier: lesson.lessonId, content: content, trigger: trigger)
                
                // Schedule the request.
                let center = UNUserNotificationCenter.current()
                center.add(request) { error in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
                }
            }
        }
    }
    
}
