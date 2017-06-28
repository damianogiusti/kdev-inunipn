//
//  ProfileView.swift
//  InUniPn
//
//  Created by edward ilie on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol ProfileView: BaseView {

    func myPreferedNewsList(withNewsList: [News], andColor color : UIColor)
    
    func myJoinedLessonsList(withLessonsList : [Lesson], andColor color : UIColor)
    
    func navigateToSettingsForm()
}
