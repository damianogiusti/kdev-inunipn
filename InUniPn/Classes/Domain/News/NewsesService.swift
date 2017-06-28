//
//  NewsesService.swift
//  InUniPn
//
//  Created by edward ilie on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//


import Foundation

enum NewsesErrors: Error {
    case newsNotExisting
}

class NewsesService: BaseService {
    
    private let token: String
    private let newsRepository: NewsRepository
    
    init(withToken token: String) {
        self.token = token
        self.newsRepository = RepositoryFactory.newsRepository(withToken: token)
    }
    
    /// Save a news
    func joinNews(byId newsId: String, onSuccess: SuccessBlock<News>? = nil, onError: ErrorBlock? = nil) {
        self.markNews(byId: newsId, asJoined: true, onSuccess: onSuccess, onError: onError)
    }
    func searchNewses(withKeyword keyword: String, onSuccess: @escaping SuccessBlock<[News]>) {
        
        runInBackground {
            
            let currentDate = Date()
            let newses = self.newsRepository.all().filter({ news in
                if  let containsName = news.title?.contains(keyword),
                    (containsName) && Date >= currentDate {
                    return true
                }
                return false
            })
            
            runOnUiThread {
                onSuccess(newses)
            }
        }
    }
    
    /// Gets all the joined newses
    func allJoinedNewses(fromDate date: Date? = nil, onSuccess: @escaping SuccessBlock<[News]>, onError: ErrorBlock? = nil) {
        
        runInBackground {
            
            let lessons: [News] = self.newsRepository.all()
                .filter({ news in
                    var filter = news.joined
                    if let Date = date, let newsStartDate = news.timeStart {
                        filter = filter && newsStartDate >= Date
                    }
                    return filter
                })
            
            runOnUiThread {
                onSuccess(lessons)
            }
        }
    }
    
    private func markNews(byId newsId: String, asJoined joined: Bool, onSuccess: SuccessBlock<News>?, onError: ErrorBlock?) {
        runInBackground {
            if let nes = self.newsRepository.news(byId: newsId) {
                if news.joined != joined {
                    news.joined = joined
                    if self.newsRepository.save(news: news) {
                        runOnUiThread {
                            onSuccess?(news)
                        }
                    }
                }
            } else {
                runOnUiThread {
                    onError?(NewsesErrors.newsNotExisting)
                }
            }
        }
    }
    
}
