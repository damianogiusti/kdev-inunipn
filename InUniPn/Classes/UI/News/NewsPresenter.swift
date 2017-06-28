//
//  NewsPresenter.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsPresenter: BasePresenter {

    //MARK: - variables

    //MARK: - services

    private var newsService: NewsService?
    private let userService: UserService = UserService()

    //MARK: - view

    private weak var newsView : NewsView?

    private(set) var newsList: [News] = []

    //MARK: - lifecycle methods

    func create(withView view: NewsView) {
        newsView = view

        guard let token: String = userService.currentUser()?.accessToken else {
            #if DEBUG
                fatalError("Cannot create the NewsPresenter without a token")
            #else
                return
            #endif
        }

        newsService = NewsService(withToken: token)
    }

    //MARK: - user interaction methods

    func showLessonsView(){

    }

    func showProfile(){

    }

    func markNewsAsFavourite(byId newsId: String) {
        newsService?.addNewsToFavorites(byId: newsId, onSuccess: updateNewsView)
    }

    func showNewsDetail(withNews news: News){
        newsView?.navigateToDetailNews(withNews: news)

    }

    func shareNews(withNews news: News){
        
    }

    func loadNews(withQueryString queryString: String? = nil){

        if let string = queryString{
            newsService?.searchNewses(withKeyword: string, onSuccess: displayNews)
        } else {
            newsService?.all(onSuccess: displayNews)
        }
    }
    
    //MARK: - private methods
    
    func displayNews(withNews news : [News]) {
        newsView?.displayNews(withNewsList: news)
    }

    func updateNewsView(news: News) {
        if let index = newsList.index(where: { n in n.newsId == news.newsId }) {
            newsView?.updateNewsView(news: news, atIndex: index)
        } else {
            newsView?.displayNews(withNewsList: newsList)
        }
    }

}
