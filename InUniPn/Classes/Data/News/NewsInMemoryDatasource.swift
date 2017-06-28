//
//  NewsInMemoryRepo.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsInMemoryDatasource{
    
    
    public static let sharedInstance = NewsInMemoryDatasource()
    
    private static let expirationTime: TimeInterval = 5 * 60 // 5 mins
    
    var expirationDate = Date()
    
    private var dataset: [String: News] = [:]
    
    func news(byId id: String) -> News?{
        return dataset[id]
    }
    
    @discardableResult
    func save(news: News) -> Bool{
        dataset[news.newsId] = news
        return true
    }
    
    @discardableResult
    func saveAll(newsList: [News]) -> Bool{
        for news in newsList {
            dataset[news.newsId] = news
        }
        return true
    }
    
    @discardableResult
    func delete(byId id: String) -> Bool{
        dataset[id] = nil
        return true
    }
    
    @discardableResult
    func all() -> [News]{
        return dataset.values.filter({ _ in true })   
    }    
    
    
    @discardableResult
    func deleteAll() -> Bool {
        dataset = [:]
        return true
    }
    
    
    func isExpired() -> Bool {
        return expirationDate < Date()
    }
    
    func renew() {
        expirationDate = Date(timeIntervalSinceNow: NewsInMemoryDatasource.expirationTime)
    }
    
}
