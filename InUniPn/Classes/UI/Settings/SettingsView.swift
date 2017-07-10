//
//  SettingsView.swift
//  InUniPn
//
//  Created by Damiano Giusti on 10/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

protocol SettingsView: BaseView {

    func showUserName(name: String?)

    func showUniversities(unis: [University], withSelection: String?, atIndex: Int?)

    func showNotifyForLessons(enabled: Bool)

    func showReminderIntervals(intervals: [String])

    func showLessonsReminderInterval(string: String, rawValue: Int)
}
