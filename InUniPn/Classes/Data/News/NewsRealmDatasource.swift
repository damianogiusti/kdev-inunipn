//
//  NewsSQLRepository.swift
//  InUniPn
//
//  Created by Damiano Giusti on 04/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealmDatasource: BaseRealmDatasource {

    typealias DM = DMNews
    typealias M = News

    func mapToModel(dataModel: DMNews?) -> News? {
        if let realmNews = dataModel {
            let news = News(withId: realmNews.newsId)
            news.title = realmNews.title
            news.content = realmNews.content
            news.createdDate = realmNews.createdDate
            news.imageUrl = realmNews.imageUrl
            news.link = realmNews.link
            news.page = realmNews.page
            news.starred = realmNews.starred
            return news
        } else {
            return nil
        }
    }

    func mapToDataModel(model: News?) -> DMNews? {
        if let news = model {
            let realmNews = DMNews(withId: news.newsId)
            realmNews.title = news.title
            realmNews.content = news.content
            realmNews.createdDate = news.createdDate
            realmNews.imageUrl = news.imageUrl
            realmNews.link = news.link
            realmNews.page = news.page
            realmNews.starred = news.starred
            return realmNews
        } else {
            return nil
        }
    }
}
