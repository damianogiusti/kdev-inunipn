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
    
    func displayLessons(withLessonList: [String: [LessonToDisplay]])
    
    func displayJoiningChoice(isAlreadyJoined : Bool)
    
}
