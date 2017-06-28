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
            memoryDatasource.saveAll(newsList: restDatasource.all())
            memoryDatasource.renew()
            return memoryDatasource.news(byId: id)
        }
    }
    
    func all() -> [News] {
        if !memoryDatasource.isExpired() {
            return memoryDatasource.all()
        } else {
            let newsList = restDatasource.all()
            memoryDatasource.deleteAll()
            memoryDatasource.saveAll(newsList: newsList)
            memoryDatasource.renew()
            return newsList
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
