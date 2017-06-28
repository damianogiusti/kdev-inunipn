//
//  NewsTableViewController.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet

class NewsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    fileprivate let cellNibName = String(describing: NewsTableViewCell.self)
    fileprivate let cellReuseIdentifier = String(describing: NewsTableViewCell.self)
    fileprivate let placeholderImage = "https://bytesizemoments.com/wp-content/uploads/2014/04/placeholder.png"

    fileprivate let presenter = NewsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.create(withView: self)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.register(UINib(nibName: cellNibName, bundle: nil),
                           forCellReuseIdentifier: cellReuseIdentifier)

        presenter.loadNews()
    }

    fileprivate func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dddd',' dd'/'MM'/'yyyy"
        dateFormatter.locale = Calendar.current.locale
        return dateFormatter.string(from: date)
    }
}


extension NewsTableViewController: NewsView {

    func displayNews(withNewsList list: [News]) {
        tableView.reloadData()
    }

    func updateNewsView(news: News, atIndex index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    func navigateToDetailNews(withNews: News) {
        
    }

    func showMessage(withMessage message: String) {

    }

    func showError(withError error: String) {

    }
}


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
            let index = content.index(content.startIndex, offsetBy: 50)
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
            cell.starButton.setImage(#imageLiteral(resourceName: "star_yellow"), for: .normal)
        } else {
            cell.starButton.setImage(#imageLiteral(resourceName: "star_blank"), for: .normal)
        }

        cell.newsImageView.sd_setImage(with: URL(string: news.imageUrl ?? placeholderImage))

        cell.shareButton.addTarget(self, action: #selector(favoriteButtonPressed(forNewsId:)), for: .touchUpInside)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}


// MARK: - NewsTableViewCellDelegate


extension NewsTableViewController {

    @objc func favoriteButtonPressed(forNewsId newsId: String) {
        presenter.markNewsAsFavourite(byId: newsId)
    }

    func shareButtonPressed(cell: NewsTableViewCell, shareButton button: UIButton) {
        // share news
    }
}


// MARK: - TableView Empty

extension NewsTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: Strings.noNewsPresent)
    }
}

