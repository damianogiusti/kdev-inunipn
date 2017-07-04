//
//  NewsTableViewDelegate.swift
//  InUniPn
//
//  Created by Damiano Giusti on 04/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet

class NewsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    var cellNibName = ""
    var cellReuseIdentifier = ""

    var dataset: [News] = []

    var shareButtonPressClosure: ((UIButton) -> Void)?
    var favoriteButtonPressClosure: ((UIButton) -> Void)?
    var scrollViewWillBeginDraggingClosure: ((UIScrollView) -> Void)?
    var scrollViewDidScrollClosure: ((UIScrollView) -> Void)?

    fileprivate let placeholderImage = "https://bytesizemoments.com/wp-content/uploads/2014/04/placeholder.png"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataset.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Cannot display a news without a NewsTableViewCell")
        }

        let news: News = dataset[indexPath.row]

        cell.selectedBackgroundView = nil
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
            cell.starButton.setImage(#imageLiteral(resourceName: "star_yellow"), for: .normal)
        } else {
            cell.starButton.setImage(#imageLiteral(resourceName: "star_blank"), for: .normal)
        }

        cell.newsImageView.sd_setImage(with: URL(string: news.imageUrl ?? placeholderImage))

        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(self.shareButtonPressed(_:)), for: .touchUpInside)

        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(self.favoriteButtonPressed(_:)), for: .touchUpInside)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewWillBeginDraggingClosure?(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollClosure?(scrollView)
    }

    @objc fileprivate func shareButtonPressed(_ button: UIButton) {
        shareButtonPressClosure?(button)
    }

    @objc fileprivate func favoriteButtonPressed(_ button: UIButton) {
        favoriteButtonPressClosure?(button)
    }

    fileprivate func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee',' dd'/'MM'/'yyyy"
        dateFormatter.locale = Calendar.current.locale
        return dateFormatter.string(from: date)
    }
}

// MARK: - TableView Empty

extension NewsTableViewDelegate: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: Strings.noNewsPresent)
    }
}
