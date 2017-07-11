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
    private var lessonsService: LessonsService?
    private var newsService: NewsService?
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
        guard let user = userService.currentUser(), let token = user.accessToken else {
            fatalError("Cannot launch settings without a user :(")
        }

        self.user = user

        lessonsService = LessonsService(withToken: token)
        newsService = NewsService(withToken: token)

        view.showUserName(name: user.displayName)
        view.showReminderIntervals(intervals: timeIntervals)

        let interval = NotificationPreferences.getNotificationBeforeMinutes()
        view.showLessonsReminderInterval(string: timeIntervals[interval], rawValue: interval)
        view.showNotifyForLessons(enabled: NotificationPreferences.areNotificationsEnabled())
    }

    //MARK: - user interaction methods

    func retrieveUniversities() {
        universitiesService.all(onSuccess: dispatchUniversities, onError: onRetrievingUniversitiesError)
    }

    func changeNotificationStatus(status: Bool) {
        NotificationPreferences.setNotificationsEnabled(status: status)
    }

    func changeNotificationInterval(newValueMinutes value: Int?) {
        if let value = value {
            NotificationPreferences.setNotificationBefore(minutes: value)
        }
    }

    func changeUserName(name: String?) {
        if let user = user, user.displayName != name {
            user.displayName = name
            userService.save(user: user)
        }
    }

    func changeUniversity(uni: String) {
        if let user = user, user.university != uni {
            user.university = uni
            userService.save(user: user)
        }
    }

    func logout() {
        if let user = user {
            userService.delete(user: user)
            newsService?.deleteNews(onSuccess: {
                self.lessonsService?.deleteLessons(onSuccess: {
                    self.view?.navigateToLogin()
                })
            })

        }
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
