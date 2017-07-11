//
//  LessonView.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol LessonView: BaseView {
    
    func navigateToProfile()
    
    func navigateToNews()
    
    func displayLessons(withLessonList: [Day])

    func updateLessonView(days: [Day], atIndexPath indexPath: IndexPath)
    
    func displayJoiningChoice(isAlreadyJoined : Bool)

    func showUniversitiesForFilter(titles: [String])

    func showDefaultUniversity(atIndex: Int)
    
}
