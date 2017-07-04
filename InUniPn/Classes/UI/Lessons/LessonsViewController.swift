//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class LessonsViewController: UIViewController {

    @IBOutlet var lessonsTableView: UITableView!
    let lessonCellIdentifier = "lessonCell"

    private let lessonPresenter = LessonPresenter()

    let searchController = UISearchController(searchResultsController: nil)

    fileprivate let tableViewDelegate = LessonsTableViewDelegate()


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

        tableViewDelegate.cellReuseIdentifier = lessonCellIdentifier

        lessonsTableView.delegate = tableViewDelegate
        lessonsTableView.dataSource = tableViewDelegate
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


    func filterContentForSearchText(searchText: String, scope: String = "All") {

        tableViewDelegate.filteredDataset = []
        for day in tableViewDelegate.dataset {

            tableViewDelegate.filteredDataset.append(Day(date: day.date ,lessons: day.lessons.filter { lesson in
                return (lesson.name.lowercased().contains(searchText.lowercased())) ||
                        (lesson.teacher.lowercased().contains(searchText.lowercased())) ||
                        (lesson.classroom.lowercased().contains(searchText.lowercased()))
            }))
        }

        tableViewDelegate.filteredDataset = tableViewDelegate.filteredDataset.filter{day in day.lessons.count>0}

        lessonsTableView.reloadData()
    }

}

extension LessonsViewController: LessonView {

    func displayLessons(withLessonList list: [Day]) {
        tableViewDelegate.dataset = list
        tableViewDelegate.filteredDataset = []
        tableViewDelegate.filteredDataset.append(contentsOf: list)
        lessonsTableView.reloadData()
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
}

extension LessonsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

