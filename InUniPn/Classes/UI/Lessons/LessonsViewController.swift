//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class LessonsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, LessonView{

    func displayLessons(withLessonList list: [Day]) {
        days = list
        filteredDays = []
        filteredDays.append(contentsOf: days)
        lessonsTableView.reloadData()
    }


    @IBOutlet var lessonsTableView: UITableView!
    let lessonCellIdentifier = "lessonCell"

    private let lessonPresenter = LessonPresenter()

    var days = [Day]()
    var filteredDays = [Day]()

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

        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        lessonsTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor.lilyWhite
        searchController.searchBar.placeholder = "Cerca le lezioni"
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchController.searchBar.setValue("Chiudi", forKey:"_cancelButtonText")
        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.fireBrickRed]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], for: UIControlState.normal)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        appDelegate.tabBarController?.title = Strings.lessons
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredDays.count
        }
        return days.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredDays[section].lessons.count
        }
        if days.count > 0{
        return days[section].lessons.count
        }
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LessonCell = tableView.dequeueReusableCell(withIdentifier: lessonCellIdentifier, for: indexPath as IndexPath) as! LessonCell

        let lesson: LessonToDisplay
        if searchController.isActive && searchController.searchBar.text != "" {
            lesson = filteredDays[indexPath.section].lessons[indexPath.row]

        } else {
            lesson = days[indexPath.section].lessons[indexPath.row]
        }
        cell.startTimeLabel?.text = lesson.startTime
        cell.endTimeLabel?.text = lesson.endTime
        cell.lessonLabel?.text = lesson.name
        cell.teacherLabel?.text = lesson.teacher
        cell.classroomLabel?.text = lesson.classroom

        return cell
    }


     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if days.count > 0{
        return days[section].date
        }
        return ""
    }

    func navigateToProfile() {

    }

    func navigateToNews() {

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

        filteredDays = []
        for day in days {

            filteredDays.append(Day(date: day.date ,lessons: day.lessons.filter { lesson in
                return (lesson.name.lowercased().contains(searchText.lowercased())) ||
                        (lesson.teacher.lowercased().contains(searchText.lowercased())) ||
                        (lesson.classroom.lowercased().contains(searchText.lowercased()))
            }))
        }

        filteredDays = filteredDays.filter{day in day.lessons.count>0}

        lessonsTableView.reloadData()
    }

}

extension LessonsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

