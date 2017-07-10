//
//  SettingsPresenter.swift
//  InUniPn
//
//  Created by Damiano Giusti on 10/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

class SettingsPresenter: BasePresenter {

    private let universitiesService = UniversitiesServices()
    private let userService = UserService()
    private let notificationsManager = NotificationPreferences()

    private weak var view: SettingsView?
    private var user: User?

    lazy var timeIntervals: [String] = {
        (0..<120).map({ (number) in
            var title = ""
            let minuteSingular = Strings.minuteSingular
            let minutePlural = Strings.minutePlural
            if number == 0 {
                title = "\(number + 1) \(minuteSingular)"
            } else {
                title = "\(number + 1) \(minutePlural)"
            }
            return title
        })
    }()

    func create(withView view: SettingsView) {
        self.view = view
        guard let user = userService.currentUser() else {
            fatalError("Cannot launch settings without a user :(")
        }

        self.user = user
        view.showUserName(name: user.displayName)
        view.showReminderIntervals(intervals: timeIntervals)

        let interval = NotificationPreferences.getNotificationBeforeMinutes()
        view.showLessonsReminderInterval(string: timeIntervals[interval], rawValue: interval)
    }

    //MARK: - user interaction methods

    func retrieveUniversities() {
        universitiesService.all(onSuccess: dispatchUniversities, onError: onRetrievingUniversitiesError)
    }

    private func dispatchUniversities(unis: [University]) {
        let index = unis.index { (uni) -> Bool in
            return uni.code == self.user?.university
        }
        view?.showUniversities(unis: unis, withSelection: user?.university, atIndex: index)
    }

    private func onRetrievingUniversitiesError(error: Error) {
        
    }

}
