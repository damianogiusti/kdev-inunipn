//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class fakeLesson {
    var start: String
    var end: String
    var lesson: String
    var teacher: String
    var classroom: String
    
    init (start: String, end: String, lesson: String, teacher: String, classroom: String) {
        self.start = start
        self.end = end
        self.lesson = lesson
        self.teacher = teacher
        self.classroom = classroom
    }
}

class LessonsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var lessonsTableView: UITableView!
    let lessonCellIdentifier = "lessonCell"
    
    var fakeData = [fakeLesson]()
    
    
    ///associo il tab item al controller
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Orari", image: UIImage(named: "ios-time-outline"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fakeData.append(fakeLesson(start: "10:00", end: "11:00", lesson: "Soft Skills", teacher: "Claudia Cilione", classroom: "Laboratorio L3"))
        fakeData.append(fakeLesson(start: "09:00", end: "12:00", lesson: "Sviluppo in Android", teacher: "Giuseppe Merlino", classroom: "Laboratorio L3"))
        
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
        return fakeData.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LessonCell = tableView.dequeueReusableCell(withIdentifier: lessonCellIdentifier, for: indexPath as IndexPath) as! LessonCell
        
        let rowData = fakeData[indexPath.row]
        cell.startTimeLabel?.text = rowData.start
        cell.endTimeLabel?.text = rowData.end
        cell.lessonLabel?.text = rowData.lesson
        cell.teacherLabel?.text = rowData.teacher
        cell.classroomLabel?.text = rowData.classroom
        
        return cell
    }
    
}
