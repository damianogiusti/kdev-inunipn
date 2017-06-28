//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class LessonsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, LessonView{
    
    @IBOutlet var lessonsTableView: UITableView!
    let lessonCellIdentifier = "lessonCell"
    
    private let lessonPresenter = LessonPresenter()
    
    var lessonList = [Lesson]()
    
    
    ///associo il tab item al controller
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Orari", image: UIImage(named: "ios-time-outline"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonPresenter.create(withView: self)
        lessonPresenter.loadLessons()
        
        lessonsTableView.delegate = self
        lessonsTableView.dataSource = self
        lessonsTableView.rowHeight = UITableViewAutomaticDimension
        lessonsTableView.estimatedRowHeight = 100.0
        lessonsTableView.tableFooterView = UIView()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LessonCell = tableView.dequeueReusableCell(withIdentifier: lessonCellIdentifier, for: indexPath as IndexPath) as! LessonCell
        
        let lesson = lessonList[indexPath.row]
        cell.startTimeLabel?.text = lesson.timeStart?.description
        cell.endTimeLabel?.text = lesson.timeEnd?.description
        cell.lessonLabel?.text = lesson.course
        cell.teacherLabel?.text = lesson.teacher
        cell.classroomLabel?.text = lesson.classroom
        
        return cell
    }
    
    func navigateToProfile() {
        
    }
    
    func navigateToNews() {
        
    }
    
    func displayLessons(withLessonList list: [Lesson]) {
        lessonList = list
        lessonsTableView.reloadData()
    }
    
    func displayJoiningChoice(isAlreadyJoined : Bool) {
        
    }
    
    func showError(withError error : String) {
        displayError(withMessage: error)
    }
    
    func showMessage(withMessage message : String) {
        displayAlert(withMessage: message)
    }

    
}
