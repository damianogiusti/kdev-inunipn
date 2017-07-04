//
//  NotificationPreferences.swift
//  InUniPn
//
//  Created by Mattia Contin  on 04/07/2017.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class NotificationPreferences {
    
    private static let k_minutes = "minutes"
    
    static func setNotificationBefore(minutes: Int) {
        UserDefaults.standard.setValue(minutes, forKey: k_minutes)
    }
    
    static func getNotificationBeforeMinutes() -> Int {
        var minutes = UserDefaults.standard.integer(forKey: k_minutes)
        if minutes == 0 {
            minutes = 30
            setNotificationBefore(minutes: minutes)
        }
        return minutes
    }
    
}
