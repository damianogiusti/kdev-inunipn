//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class LessonsViewController: UIViewController, UISearchBarDelegate {

    func displayLessons(withLessonList list: [Day]) {
        tableViewDelegate.dataset = list
        lessonsTableView.reloadData()
    }

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

        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.fireBrickRed]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], for: UIControlState.normal)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        appDelegate.tabBarController?.title = Strings.lessons
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lessonPresenter.loadLessons(withQueryString: searchText)
    }
}

extension LessonsViewController: LessonView {

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

