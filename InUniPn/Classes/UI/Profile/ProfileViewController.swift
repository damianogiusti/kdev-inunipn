//
//  ProfileViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import SDWebImage

fileprivate enum SegmentItems: Int {
    case news, lessons
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!

    fileprivate let presenter = ProfilePresenter()

    // News
    fileprivate let newsCellNibName = String(describing: NewsTableViewCell.self)
    fileprivate let newsCellReuseIdentifier = String(describing: NewsTableViewCell.self)
    fileprivate let newsTableViewDelegate = NewsTableViewDelegate()

    // Lessons
    fileprivate let lessonsCellNibName = String(describing: LessonTableViewCell.self)
    fileprivate let lessonsCellReuseIdentifier = String(describing: LessonTableViewCell.self)
    fileprivate let lessonsTableViewDelegate = LessonsTableViewDelegate()

    private var currentSegment: SegmentItems {
        return SegmentItems(rawValue: segment.selectedSegmentIndex) ?? .news
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.create(withView: self)

        userImageView.layer.masksToBounds = false
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true

        segment.addTarget(self, action: #selector(self.didPressSegment(_:)), for: .valueChanged)
        segment.apportionsSegmentWidthsByContent = false
        segment.setTitle(Strings.news, forSegmentAt: SegmentItems.news.rawValue)
        segment.setTitle(Strings.lessons, forSegmentAt: SegmentItems.lessons.rawValue)

        // setup table view
        tableView.register(UINib(nibName: newsCellNibName, bundle: nil), forCellReuseIdentifier: newsCellReuseIdentifier)
        tableView.register(UINib(nibName: lessonsCellNibName, bundle: nil), forCellReuseIdentifier: lessonsCellReuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        // setup news delegate
        newsTableViewDelegate.cellNibName = newsCellNibName
        newsTableViewDelegate.cellReuseIdentifier = newsCellReuseIdentifier
        newsTableViewDelegate.favoriteButtonPressClosure = favoriteButtonPressed
        newsTableViewDelegate.shareButtonPressClosure = shareButtonPressed
        newsTableViewDelegate.scrollViewWillBeginDraggingClosure = scrollViewWillBeginDragging
        newsTableViewDelegate.scrollViewDidScrollClosure = scrollViewDidScroll

        // setup lessons delegate
        lessonsTableViewDelegate.cellNibName = lessonsCellNibName
        lessonsTableViewDelegate.cellReuseIdentifier = lessonsCellReuseIdentifier
        lessonsTableViewDelegate.didSelectRowAtIndexPathClosure = lessonsTableView(_:didSelectRowAt:)

        // setup button bar item click
        appDelegate.settingsButtonItemPressedClosure = self.didPressSettingsButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabBarController?.title = Strings.profile
        appDelegate.tabBarController?.navigationItem.rightBarButtonItem = appDelegate.settingsBarItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.loadUser()

        switch currentSegment {
        case .news:
            setupForNews()
        case .lessons:
            setupForLessons()
        }
    }

    @objc fileprivate func didPressSegment(_: Any) {
        switch segment.selectedSegmentIndex {
        case SegmentItems.news.rawValue:
            didPressNewsSegment()
            break
        case SegmentItems.lessons.rawValue:
            didPressLessonsSegment()
            break
        default:
            break
        }
    }

    fileprivate func didPressNewsSegment() {
        setupForNews()
    }

    fileprivate func didPressLessonsSegment() {
        setupForLessons()
    }

    fileprivate func didPressSettingsButton() {
        presenter.showSettings()
    }

    fileprivate func setupForNews() {
        tableView.delegate = newsTableViewDelegate
        tableView.dataSource = newsTableViewDelegate
        tableView.emptyDataSetDelegate = newsTableViewDelegate
        tableView.emptyDataSetSource = newsTableViewDelegate
        tableView.separatorStyle = .none
        presenter.loadNews()
    }

    fileprivate func setupForLessons() {
        tableView.delegate = lessonsTableViewDelegate
        tableView.dataSource = lessonsTableViewDelegate
        tableView.emptyDataSetDelegate = lessonsTableViewDelegate
        tableView.emptyDataSetSource = lessonsTableViewDelegate
        tableView.separatorStyle = .none // TODO .singleLine
        presenter.loadLessons()
    }
}

extension ProfileViewController: ProfileView  {

    func showUser(userInfo: UserInfo) {
        nameSurnameLabel.text = userInfo.displayName
        userImageView.sd_setImage(with: URL(string: userInfo.imageURL))
        universityLabel.text = userInfo.university
        universityLabel.sizeToFit()
    }

    func myPreferedNewsList(withNewsList list: [News], andColor color: UIColor) {
        newsTableViewDelegate.dataset = list
        tableView.reloadData()
    }

    func showJoinedLessonsList(days: [Day], andColor color: UIColor) {
        lessonsTableViewDelegate.dataset = days
        lessonsTableViewDelegate.filteredDataset = []
        tableView.reloadData()
    }

    func navigateToSettingsForm() {
        let vc = SettingsViewController()
        appDelegate.navigationController?.pushViewController(vc, animated: true)
    }

    func showError(withError error: String) {

    }

    func showMessage(withMessage message: String) {

    }

    func showProgress() {
        // showProgressDialog(onView: self.view, withMessage: Strings.loading)
    }

    func hideProgress() {
        // hideProgressDialog()
    }

}

// MARK: - NewsTableViewCellDelegate


extension ProfileViewController {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }


    @objc func favoriteButtonPressed(_ button: UIButton) {
        let news = newsTableViewDelegate.dataset[button.tag]
        presenter.removeNewsFromFavorites(byId: news.newsId)
    }

    func shareButtonPressed(_ button: UIButton) {
        //
    }
}

// MARK: - LessonsTableViewCellDelegate

extension ProfileViewController {

    func lessonsTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
