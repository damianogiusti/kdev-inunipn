//
//  NewsTableViewController.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let cellNibName = String(describing: NewsTableViewCell.self)
    private let cellReuseIdentifier = String(describing: NewsTableViewCell.self)

    fileprivate let presenter = NewsPresenter()
    fileprivate let tableViewDelegate = NewsTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.create(withView: self)

        tableViewDelegate.cellNibName = cellNibName
        tableViewDelegate.cellReuseIdentifier = cellReuseIdentifier
        tableViewDelegate.shareButtonPressClosure = self.shareButtonPressed
        tableViewDelegate.favoriteButtonPressClosure = self.favoriteButtonPressed

        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        tableView.emptyDataSetSource = tableViewDelegate
        tableView.emptyDataSetDelegate = tableViewDelegate
        tableView.register(UINib(nibName: cellNibName, bundle: nil),
                           forCellReuseIdentifier: cellReuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabBarController?.title = Strings.news
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.loadNews()
    }
}


extension NewsTableViewController: NewsView {

    func displayNews(withNewsList list: [News]) {
        tableViewDelegate.dataset = list
        tableView.reloadData()
    }

    func updateNewsView(news: News, atIndex index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }

    func navigateToDetailNews(withNews: News) {
        
    }

    func showMessage(withMessage message: String) {

    }

    func showError(withError error: String) {

    }

    func showProgress() {
        showProgressDialog(onView: tableView, withMessage: Strings.loading)
    }

    func hideProgress() {
        hideProgressDialog()
    }
}


// MARK: - NewsTableViewCellDelegate


extension NewsTableViewController {

    @objc func favoriteButtonPressed(_ button: UIButton) {
        let news = presenter.newsList[button.tag]
        presenter.toggleNewsFavouriteState(ofNews: news)
    }

    func shareButtonPressed(_ button: UIButton) {
        //
    }
}
