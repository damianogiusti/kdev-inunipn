//
//  ProfilePresenter.swift
//  InUniPn
//
//  Created by edward ilie on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class ProfilePresenter: BasePresenter {
    
    //MARK: - variables
    
    private var profileView : ProfileView?
    
    func create(withView view: ProfileView) {
        profileView = view
    }
    
    //MARK: - user interaction methods
    
    func userProfile(withName name: String, image: UIImageView, university: String) {
        
    
    }

    //MARK: - private methods

    private func onNewsList(withNewsList newses: [News]) {
        profileView?.myPreferedNewsList(withNewsList: newses, andColor: UIColor.yellow)
    }

    private func onLessonsList(withLessonsList lessons: [Lesson]) {
        profileView?.myJoinedLessonsList(withLessonsList : lessons, andColor: UIColor.yellow)
    }

    private func onSettingsForm(_: Any) {
        profileView?.navigateToSettingsForm()
    }

    private func onNewsList(_ : Any) {

    }

}
