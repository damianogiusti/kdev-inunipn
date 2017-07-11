//
//  NewsTableViewController.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsTableViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let cellNibName = String(describing: NewsTableViewCell.self)
    private let cellReuseIdentifier = String(describing: NewsTableViewCell.self)

    fileprivate let presenter = NewsPresenter()

    private var query = ""

    fileprivate let tableViewDelegate = NewsTableViewDelegate()
    private var tapRecognizer: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.create(withView: self)

        tableViewDelegate.cellNibName = cellNibName
        tableViewDelegate.cellReuseIdentifier = cellReuseIdentifier
        tableViewDelegate.shareButtonPressClosure = self.shareButtonPressed
        tableViewDelegate.favoriteButtonPressClosure = self.favoriteButtonPressed
        tableViewDelegate.didSelectRowAtIndexPathClosure = self.newsTableView(_:didSelectRowAt:)

        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        tableView.emptyDataSetSource = tableViewDelegate
        tableView.emptyDataSetDelegate = tableViewDelegate
        tableView.register(UINib(nibName: cellNibName, bundle: nil),
                           forCellReuseIdentifier: cellReuseIdentifier)

        searchBar.barTintColor = .primaryColor
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTouchTableView))
        self.tapRecognizer = tapRecognizer
        tableView.addGestureRecognizer(tapRecognizer)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tapRecognizer?.isEnabled = true
    }

    @objc func didTouchTableView() {
        view.endEditing(true)
        tapRecognizer?.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabBarController?.title = Strings.news
        appDelegate.tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.loadNews(withQueryString: query)
    }

    fileprivate func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee',' dd'/'MM'/'yyyy"
        dateFormatter.locale = Calendar.current.locale
        return dateFormatter.string(from: date)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query = searchText
        presenter.loadNews(withQueryString: query)
    }
}


extension NewsTableViewController: NewsView {

    func displayNews(withNewsList list: [News]) {
        tableViewDelegate.dataset = list
        tableView.reloadData()
    }

    func updateNewsView(news: News, atIndex index: Int) {
        tableViewDelegate.dataset[index] = news
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }

    func navigateToDetailNews(withNews: News) {

    }

    func shareNews(activity: UIActivityViewController) {

        self.present(activity, animated: true, completion: nil)

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

    func newsTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsDetailViewController = UIStoryboard(name: "NewsDetail", bundle: nil)
            .instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
            newsDetailViewController.news = tableViewDelegate.dataset[indexPath.row]
            self.appDelegate.navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
    }

    @objc func favoriteButtonPressed(_ button: UIButton) {
        let news = tableViewDelegate.dataset[button.tag]
        presenter.toggleNewsFavouriteState(ofNews: news)
    }

    func shareButtonPressed(_ button: UIButton) {
        let news = tableViewDelegate.dataset[button.tag]
        presenter.shareNews(withNews: news)
    }
}
