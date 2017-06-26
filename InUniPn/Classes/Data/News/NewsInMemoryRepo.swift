//
//  NewsInMemoryRepo.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsInMemoryRepo: NewsRepository{
    
    private var dataset: [String: News] = [:]
    
    func news(byId id: String) -> News?{
        return dataset[id]
    }
    
    func save(news: News) -> Bool{
        dataset[news.newsId] = news
        return true
    }
    
    func saveAll(newsList: [News]) -> Bool{
        for news in newsList {
            dataset[news.newsId] = news
        }
        return true
    }
    
    func delete(byId id: String) -> Bool{
        dataset[id] = nil
        return true
    }
    
    func all() -> [News]{
        return dataset.values.filter({ _ in true })   
    }
    
}
