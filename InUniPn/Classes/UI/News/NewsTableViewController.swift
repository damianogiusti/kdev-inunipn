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

    private let cellNibName = String(describing: NewsTableViewCell.self)
    private let cellReuseIdentifier = String(describing: NewsTableViewCell.self)

    fileprivate let presenter = NewsPresenter()

    private var query = ""

    fileprivate let tableViewDelegate = NewsTableViewDelegate()

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


<<<<<<< HEAD
// MARK: - UITableViewDelegate


extension NewsTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Cannot display a news without a NewsTableViewCell")
        }

        let news: News = presenter.newsList[indexPath.row]

        cell.titleLabel.text = news.title

        if let content = news.content {
            let index = content.index(content.startIndex, offsetBy: 100)
            cell.contentLabel.text = content.substring(to: index)
        } else {
            cell.contentLabel.text = nil
        }

        if let date = news.createdDate {
            cell.dateLabel.text = formatDate(date: date)
        } else {
            cell.dateLabel.text = nil
        }

        if news.starred {
            cell.starButton.setImage(#imageLiteral(resourceName: "ios-star"), for: .normal)
        } else {
            cell.starButton.setImage(#imageLiteral(resourceName: "ios-star-outline"), for: .normal)
        }

        cell.newsImageView.sd_setImage(with: URL(string: news.imageUrl ?? placeholderImage))
=======
>>>>>>> ecba3e57c64fa44c300def8f848951cf191075b3

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
