//
//  NewsesService.swift
//  InUniPn
//
//  Created by edward ilie on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//


import Foundation

enum NewsesErrors: Error {
    case newsNotExisting, errorDeletingNews
}

class NewsService: BaseService {
    
    private let token: String
    private let newsRepository: NewsRepository
    
    init(withToken token: String) {
        self.token = token
        self.newsRepository = RepositoryFactory.newsRepository(withToken: token)
    }

    /// Gets all the news
    func all(ofPage page: Int? = nil, onSuccess: @escaping SuccessBlock<[News]>, onError: ErrorBlock? = nil) {

        runInBackground {

            var news: [News]
            if let page = page {
                news = self.newsRepository.news(ofPage: page)
            } else {
                news = self.newsRepository.all()
            }

            runOnUiThread {
                onSuccess(news)
            }
        }
    }
    
    /// Get the detail of a news
    func detailNews(byId id: String, onSuccess: @escaping SuccessBlock<News>, onError: ErrorBlock? = nil) {
        runInBackground {
            
            let news = self.newsRepository.news(byId: id)

            if let news = news {
                runOnUiThread {
                    onSuccess(news)
                }
            } else {
                runOnUiThread {
                    onError?(NewsesErrors.newsNotExisting)
                }
            }

        }
    }

    /// Delete a news
    func deleteNews(byId id: String, onSuccess: SuccessBlock<Void>? = nil, onError: ErrorBlock? = nil) {

        runInBackground {

            if self.newsRepository.delete(byId: id) {
                runOnUiThread {
                    onSuccess?()
                }
            } else {
                runOnUiThread {
                    onError?(NewsesErrors.errorDeletingNews)
                }
            }
        }
    }
    
    /// Adds a news to the favorites
    func addNewsToFavorites(byId newsId: String, onSuccess: SuccessBlock<News>? = nil, onError: ErrorBlock? = nil) {
        self.markNews(byId: newsId, asFavorite: true, onSuccess: onSuccess, onError: onError)
    }

    /// Removes a news to the favorites
    func removeNewsToFavorites(byId newsId: String, onSuccess: SuccessBlock<News>? = nil, onError: ErrorBlock? = nil) {
        self.markNews(byId: newsId, asFavorite: false, onSuccess: onSuccess, onError: onError)
    }

    /// Search from all the news for a matching title or content
    func searchNewses(withKeyword keyword: String, onSuccess: @escaping SuccessBlock<[News]>) {
        
        runInBackground {

            let string = keyword.lowercased()
            let newses = self.newsRepository.all().filter({ news in
                if  let containsTitle = news.title?.lowercased().contains(string),
                    let containsBody = news.content?.lowercased().contains(string),
                    containsTitle || containsBody {
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
    func allFavoriteNews(onSuccess: @escaping SuccessBlock<[News]>, onError: ErrorBlock? = nil) {
        
        runInBackground {
            
            let lessons: [News] = self.newsRepository.all().filter({ news in news.starred })
            
            runOnUiThread {
                onSuccess(lessons)
            }
        }
    }
    
    private func markNews(byId newsId: String, asFavorite favorite: Bool, onSuccess: SuccessBlock<News>?, onError: ErrorBlock?) {

        runInBackground {
            if let news = self.newsRepository.news(byId: newsId) {
                if news.starred != favorite {
                    news.starred = favorite
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
