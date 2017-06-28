//
//  LessonPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class LessonPresenter: BasePresenter {
    
    //MARK: - variables
    
    private let user : User? = nil
    
    //MARK: - services
    
    //    private var newsService
    
    private let userService : UserService = UserService()
    private var lessonService : LessonsService?
    
    //MARK: - view
    
    private var lessonView : LessonView? 
    
    //MARK: - lifecycle methods
    
    func create(withView view: LessonView, andToken token : String) {
        lessonView = view
        lessonService = LessonsService(withToken : token);
    }
    
    //MARK: - user interaction methods
    
    func showNewsView(){
        lessonView?.navigateToNews()
    }
    
    func showProfile(){
        lessonView?.navigateToProfile()
    }
    
    func loadLessons(withQueryString queryString: String?=nil){
        
        if let string = queryString{
            lessonService?.searchLessons(withKeyword: string, onSuccess: displayLessons)  
        } else {
            
        }
    }
    
    //MARK: - private methods
    
    func displayLessons(withLessons lessons : [Lesson]){
        lessonView?.displayLessons(withLessonList: lessons)
    }
    
}
