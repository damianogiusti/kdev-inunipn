//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class LessonsViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var lessonsTableView: UITableView!
    @IBOutlet weak var universitiesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    let lessonCellIdentifier = String(describing: LessonTableViewCell.self)
    let lessonCellNibName = String(describing: LessonTableViewCell.self)

    private let lessonPresenter = LessonPresenter()

    let searchController = UISearchController(searchResultsController: nil)

    fileprivate let tableViewDelegate = LessonsTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        lessonPresenter.create(withView: self)

        lessonsTableView.register(UINib(nibName: lessonCellNibName, bundle: nil), forCellReuseIdentifier: lessonCellIdentifier)
        tableViewDelegate.cellReuseIdentifier = lessonCellIdentifier
        tableViewDelegate.cellNibName = lessonCellNibName
        tableViewDelegate.didPressJoinButtonClosure = self.didPressJoinButton(atIndexPath:)

        lessonsTableView.delegate = tableViewDelegate
        lessonsTableView.dataSource = tableViewDelegate
        lessonsTableView.rowHeight = UITableViewAutomaticDimension
        lessonsTableView.estimatedRowHeight = 100.0
        lessonsTableView.tableFooterView = UIView()

        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], for: UIControlState.normal)

        universitiesSegmentedControl.tintColor = .darkPrimaryColor
        universitiesSegmentedControl.addTarget(self, action: #selector(self.didPressSegment(_:)), for: .valueChanged)

        searchBar.barTintColor = .primaryColor
        searchBar.searchBarStyle = .minimal
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        appDelegate.tabBarController?.title = Strings.lessons
        appDelegate.tabBarController?.navigationItem.rightBarButtonItem = nil

        lessonPresenter.start()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lessonPresenter.loadLessons(withQueryString: searchText)
    }

    func didPressJoinButton(atIndexPath indexPath: IndexPath) {
        lessonPresenter.toggleJoinedStateOfLesson(byId: tableViewDelegate.dataset[indexPath.section].lessons[indexPath.row].id)
    }

    @objc fileprivate func didPressSegment(_: Any) {
        lessonPresenter.selectedUniversityAtIndex(index: universitiesSegmentedControl.selectedSegmentIndex)
    }
}

extension LessonsViewController: LessonView {

    func navigateToProfile() {

    }

    func navigateToNews() {

    }

    func displayLessons(withLessonList list: [Day]) {
        tableViewDelegate.dataset = list
        lessonsTableView.reloadData()
    }

    func updateLessonView(days: [Day], atIndexPath indexPath: IndexPath) {
        tableViewDelegate.dataset = days
        lessonsTableView.reloadRows(at: [indexPath], with: .none)
    }

    func displayJoiningChoice(isAlreadyJoined : Bool) {

    }

    func showUniversitiesForFilter(titles: [String]) {
        universitiesSegmentedControl.removeAllSegments()
        for index in 0..<titles.count {
            universitiesSegmentedControl.insertSegment(withTitle: titles[index], at: index, animated: false)
        }
    }

    func showDefaultUniversity(atIndex index: Int) {
        universitiesSegmentedControl.selectedSegmentIndex = index
    }

    func showError(withError error : String) {
        displayError(withMessage: error)
    }

    func showMessage(withMessage message : String) {
        displayAlert(withMessage: message)
    }
    
}

