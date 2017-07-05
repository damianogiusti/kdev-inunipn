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
    
    required init(withToken token: String) {
        self.token = token
        self.restDatasource = NewsRestDatasource(withToken: token)
    }
    
    func news(byId id: String) -> News? {
        return storageDatasource.news(byId: id)
    }

    func news(ofPage page: Int) -> [News] {
        let newss = storageDatasource.all()
        if !newss.isEmpty {
            return storageDatasource.all().filter({ news in news.page == page })
        } else {
            if let news = restDatasource.all(ofPage: page).data {
                storageDatasource.saveAll(newsList: news)
                return storageDatasource.all().filter({ news in news.page == page })
            }
            return []
        }
    }

    func all() -> [News] {
        // the first time always call the REST API
        if NewsRepositoryImpl.allNewsCallsCount == 0 {
            NewsRepositoryImpl.allNewsCallsCount += 1

            if let news: [News] = restDatasource.all().data {
                let persistedNews: [News] = storageDatasource.all()

                // if some data is persisted, recover the starred state 
                // and apply it to the retrieved data
                if !persistedNews.isEmpty {
                    news.forEach({ n in
                        n.starred = persistedNews.filter({ pn in pn.newsId == n.newsId }).first?.starred ?? false
                    })
                }

                // update the persisted data with the REST one
                storageDatasource.saveAll(newsList: news)
                return news
            } else {
                return []
            }
        }
        // the second time check if some data is persisted, 
        // else get the REST api call result, save it, and return it
        else {
            let newss = storageDatasource.all()
            if !newss.isEmpty {
                return newss
            } else {
                if let news = restDatasource.all().data {
                    storageDatasource.saveAll(newsList: news)
                    return news
                }
                return []
            }
        }
    }
    
    func save(news: News) -> Bool {
        if storageDatasource.save(news: news) /* && others */ {
            return true
        } else {
            return false
        }
    }
    
    func delete(byId id: String) -> Bool {
        return storageDatasource.delete(byId: id)
    }
}
