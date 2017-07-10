//
//  NewsRepositoryImpl.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsRepositoryImpl: NewsRepository {

    private let token: String

    private static var allNewsCallsCount = 0
    private let storageDatasource = NewsRealmDatasource()
    private let restDatasource: NewsRestDatasource

    private let kNewsPage = "news_last_page"
    private let prefs = UserDefaults.standard
    
    required init(withToken token: String) {
        self.token = token
        self.restDatasource = NewsRestDatasource(withToken: token)
    }
    
    func news(byId id: String) -> News? {
        return storageDatasource.obj(byId: id)
    }

    func news(ofPage page: Int) -> [News] {
        let newss = storageDatasource.all().filter({ news in news.page == page })
        if !newss.isEmpty {
            return storageDatasource.all()
        } else {
            if let news = restDatasource.all(ofPage: page).data {
                storageDatasource.saveAll(objects: news)
                return storageDatasource.all().filter({ news in news.page == page })
            }
            return []
        }
    }

    func all() -> [News] {

        // the first time always call the REST API
        if NewsRepositoryImpl.allNewsCallsCount == 0 {
            NewsRepositoryImpl.allNewsCallsCount += 1

            var news: [News] = fetchAll()
            let persistedNews: [News] = storageDatasource.all()

            // if some data is persisted, recover the starred state
            // and apply it to the retrieved data
            if !persistedNews.isEmpty {

                persistedNews.forEach({ pn in
                    if !news.contains(where: { n in n.newsId == pn.newsId }) {
                        news.append(pn)
                    }
                })

                news.forEach({ n in
                    n.starred = persistedNews.filter({ pn in pn.newsId == n.newsId }).first?.starred ?? false
                })
            }

            // update the persisted data with the REST one
            storageDatasource.saveAll(objects: news)
            return news

        }
        // the second time check if some data is persisted,
        // else get the REST api call result, save it, and return it
        else {
            let newss = storageDatasource.all()
            if !newss.isEmpty {
                return newss
            } else {
                if let news = restDatasource.all().data {
                    storageDatasource.saveAll(objects: news)
                    return news
                }
                return []
            }
        }
    }

    private func fetchAll() -> [News] {
        var page = prefs.integer(forKey: kNewsPage)
        if page < 0 {
            page = 0
        }

        var newss: [News] = []
        var pageNews = fetchAll(ofPage: page)
        newss.append(contentsOf: pageNews)
        while !pageNews.isEmpty {
            page += 1
            pageNews = fetchAll(ofPage: page)
            newss.append(contentsOf: pageNews)
        }
        prefs.setValue(page - 1, forKey: kNewsPage)
        return newss
    }

    private func fetchAll(ofPage page: Int) -> [News] {
        if let news = restDatasource.all(ofPage: page).data {
            return news
        }
        return []
    }
    
    func save(news: News) -> Bool {
        if storageDatasource.save(obj: news) /* && others */ {
            return true
        } else {
            return false
        }
    }
    
    func delete(byId id: String) -> Bool {
        return storageDatasource.delete(byId: id)
    }
}
