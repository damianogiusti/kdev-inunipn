//
//  ProfilePresenter.swift
//  InUniPn
//
//  Created by edward ilie on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

struct UserInfo {
    let displayName: String
    let imageURL: String
    let university: String

    init(withName name: String, imageURL: String, university: String) {
        self.displayName = name
        self.imageURL = imageURL
        self.university = university
    }
}

class ProfilePresenter: BasePresenter {

    private var userService: UserService?
    private var newsService: NewsService?
    private var lessonsService: LessonsService?
    
    //MARK: - variables
    
    private weak var profileView : ProfileView?
    
    func create(withView view: ProfileView) {
        profileView = view
        userService = UserService()

        guard let token = userService?.currentUser()?.accessToken else {
            #if DEBUG
                fatalError("Cannot launch Profile View without a valid user")
            #else
                return
            #endif
        }

        newsService = NewsService(withToken: token)
        lessonsService = LessonsService(withToken: token)

    }

    // MARK: - view interaction methods

    func loadUser() {
        userService?.currentUser(onSuccess: showUser, onError: onError)
    }

    func loadNews() {
        profileView?.showProgress()
        newsService?.allFavoriteNews(onSuccess: onNewsList, onError: onError)
    }

    func loadLessons() {
        profileView?.showProgress()
        lessonsService?.allJoinedLessons(fromDate: Date(), onSuccess: onLessonsList, onError: onError)
    }

    func unjoinLesson(byId lessonId: String) {
        lessonsService?.unjoinLesson(byId: lessonId, onSuccess: { [weak self] _ in
            self?.loadLessons()
        }, onError: onError)
    }

    func removeNewsFromFavorites(byId newsId: String) {
        newsService?.removeNewsToFavorites(byId: newsId, onSuccess: { [weak self] _ in
            self?.loadNews()
        }, onError: onError)
    }

    // MARK: - private methods

    private func onError(error: Error) {
        profileView?.showError(withError: error.localizedDescription)
    }

    private func showUser(user: User) {
        var name = user.displayName ?? ""
        if name.trim().isEmpty {
            name = user.email ?? ""
        }
        var imageURL = user.imageUrl ?? ""
        if imageURL.trim().isEmpty {
             imageURL = gravatarUrl(forEmail: user.email ?? "")
        }
        profileView?.showUser(userInfo: UserInfo(withName: name,
                                                 imageURL: imageURL,
                                                 university: user.university ?? ""))
    }

    private func onNewsList(withNewsList newses: [News]) {
        profileView?.hideProgress()
        profileView?.myPreferedNewsList(withNewsList: newses, andColor: .yellow)
    }

    private func onLessonsList(withLessonsList lessons: [Lesson]) {
        profileView?.hideProgress()
        profileView?.showJoinedLessonsList(days: self.rawLessonsToDays(withLessons: lessons), andColor: .yellow)
    }

    private func onSettingsForm(_: Any) {
        profileView?.navigateToSettingsForm()
    }

}
