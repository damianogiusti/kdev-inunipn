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
    
    private let memoryDatasource = NewsInMemoryDatasource.sharedInstance
    private let restDatasource: NewsRestDatasource
    
    required init(withToken token: String) {
        self.token = token
        self.restDatasource = NewsRestDatasource(withToken: token)
    }
    
    func news(byId id: String) -> News? {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.news(byId: id)
        } else {
            memoryDatasource.deleteAll()
            if let news = restDatasource.all().data {
                memoryDatasource.saveAll(newsList: news)
                memoryDatasource.renew()
                return memoryDatasource.news(byId: id)
            }
            return nil
        }

    }
    
    func all() -> [News] {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.all()
        } else {
            memoryDatasource.deleteAll()
            if let news = restDatasource.all().data {
                memoryDatasource.saveAll(newsList: news)
                memoryDatasource.renew()
                return news
            }
            return []
        }
    }
    
    func save(news: News) -> Bool {
        if memoryDatasource.save(news: news) /* && others */ {
            return true
        } else {
            return false
        }
    }
    
    func delete(byId id: String) -> Bool {
        return false
    }
}
