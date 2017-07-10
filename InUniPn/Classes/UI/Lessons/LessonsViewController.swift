//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class LessonsViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var lessonsTableView: UITableView!
    let lessonCellIdentifier = String(describing: LessonTableViewCell.self)
    let lessonCellNibName = String(describing: LessonTableViewCell.self)

    private let lessonPresenter = LessonPresenter()

    let searchController = UISearchController(searchResultsController: nil)

    fileprivate let tableViewDelegate = LessonsTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        lessonPresenter.create(withView: self)
        lessonPresenter.loadLessons()

        lessonsTableView.register(UINib(nibName: lessonCellNibName, bundle: nil), forCellReuseIdentifier: lessonCellIdentifier)
        tableViewDelegate.cellReuseIdentifier = lessonCellIdentifier
        tableViewDelegate.cellNibName = lessonCellNibName
        tableViewDelegate.didPressJoinButtonClosure = self.didPressJoinButton(atIndexPath:)

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
        appDelegate.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lessonPresenter.loadLessons(withQueryString: searchText)
    }

    func didPressJoinButton(atIndexPath indexPath: IndexPath) {
        lessonPresenter.toggleJoinedStateOfLesson(byId: tableViewDelegate.dataset[indexPath.section].lessons[indexPath.row].id)
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

    func showError(withError error : String) {
        displayError(withMessage: error)
    }

    func showMessage(withMessage message : String) {
        displayAlert(withMessage: message)
    }
    
}

