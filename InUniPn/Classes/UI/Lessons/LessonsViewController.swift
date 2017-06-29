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
    var filteredLessons = [Lesson]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
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
        
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        lessonsTableView.tableHeaderView = searchController.searchBar
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredLessons.count
        }
        return lessonList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LessonCell = tableView.dequeueReusableCell(withIdentifier: lessonCellIdentifier, for: indexPath as IndexPath) as! LessonCell
        
        let lesson: Lesson
        if searchController.isActive && searchController.searchBar.text != "" {
            lesson = filteredLessons[indexPath.row]

        } else {
            lesson = lessonList[indexPath.row]
        }
        cell.startTimeLabel?.text = lesson.timeStart?.description
        cell.endTimeLabel?.text = lesson.timeEnd?.description
        cell.lessonLabel?.text = lesson.name
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
        filteredLessons = []
        filteredLessons.append(contentsOf: lessonList)
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
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredLessons = lessonList.filter { lesson in
            return (lesson.name?.lowercased().contains(searchText.lowercased()))!
            
        }
        
        lessonsTableView.reloadData()
    }
    
}

extension LessonsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

