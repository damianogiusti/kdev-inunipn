//
//  NewsDetailPresenter.swift
//  InUniPn
//
//  Created by Michele Bravo on 04/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsDetailPresenter: BasePresenter {
    
    //MARK: - variables
    
    //MARK: - services
    
    private var newsService: NewsService?
    private var userService: UserService = UserService()
    
    //MARK: - view
    
    private weak var newsDetailView : NewsDetailView?
    
    private var news: News?
    
    //MARK: - lifecycle methods
    
    func create(withView view: NewsDetailView) {
        newsDetailView = view
        
        guard let token: String = userService.currentUser()?.accessToken else {
            #if DEBUG
                fatalError("Cannot create the NewsDetailPresenter without a token")
            #else
                return
            #endif
        }
        
        newsService = NewsService(withToken: token)
    }
    
    //MARK: - user interaction methods
    
    
    func toggleNewsFavouriteState() {
        
        if let detailNews = news {
            if detailNews.starred {
                newsService?.removeNewsToFavorites(byId: detailNews.newsId, onSuccess: updateNewsView)
            } else {
                newsService?.addNewsToFavorites(byId: detailNews.newsId, onSuccess: updateNewsView)
            }
        }
    }
    
    
    func shareNews(withNews news: News){
        
    }
    
    //MARK: - private methods
    
    func displayNews(withNews newsDetail : News) {
        news = newsDetail
        news?.title = String(htmlEncodedString: (news?.title)!)
        news?.content = String(htmlEncodedString: (news?.content)!)
        newsDetailView?.displayNews(withNews: newsDetail)
    }
    
    func updateNewsView(withNews updatedNews: News) {
        
        news = updatedNews
        news?.title = String(htmlEncodedString: (news?.title)!)
        news?.content = String(htmlEncodedString: (news?.content)!)
        newsDetailView?.updateNewsDetailView(withNews: updatedNews)
        
    }

    
}
