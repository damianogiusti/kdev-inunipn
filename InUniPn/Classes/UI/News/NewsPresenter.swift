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

    func showLessonsView() {

    }

    func showProfile() {

    }
    
    func toggleNewsFavouriteState(ofNews news: News) {
        if news.starred {
            newsService?.removeNewsToFavorites(byId: news.newsId, onSuccess: updateNewsView)
        } else {
            newsService?.addNewsToFavorites(byId: news.newsId, onSuccess: updateNewsView)
        }
    }

    func showNewsDetail(withNews news: News){
        newsView?.navigateToDetailNews(withNews: news)

    }

    func shareNews(withNews news: News){
        //Set the default sharing message.
        let message = "Message goes here."
        //Set the link to share.
        if let link = NSURL(string: "http://www.google.com")
        {
            let objectsToShare :[Any] = [message, link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            newsView?.shareNews(activity: activityVC)
        }
    }

    func loadNews(withQueryString queryString: String = ""){
        if queryString.isEmpty {
            newsService?.all(onSuccess: displayNews)
        } else {
            newsService?.searchNewses(withKeyword: queryString, onSuccess: displayNews)
        }
    }

    //MARK: - private methods

    func displayNews(withNews news : [News]) {
        newsList = news
        newsView?.displayNews(withNewsList: news)
    }

    func updateNewsView(news: News) {
        if let index = newsList.index(where: { n in n.newsId == news.newsId }) {
            newsList[index] = news
            newsView?.updateNewsView(news: news, atIndex: index)
        } else {
            newsView?.displayNews(withNewsList: newsList)
        }
    }
    
}
