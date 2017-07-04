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
    
    private var user : User?
    
    //MARK: - services
    
    private var newsService : NewsService?
    
    private let userService : UserService = UserService()
    
    //MARK: - view
    
    private var newsView : NewsView?
    
    //MARK: - lifecycle methods
    
    func create(withView view: NewsView) {
        newsView = view
        
        user = userService.currentUser()
        if let token = user?.accessToken{
            newsService = NewsService(withToken : token);
        } else {
            newsView?.showError(withError: Strings.unknownError)
        }
        
        
    }
    
    //MARK: - user interaction methods
    
    func showLessonsView(){
        newsView?.navigateToLessons()
    }
    
    func showProfile(){
        newsView?.navigateToProfile()
    }
    
    func togglePreferredNews(withNews news: News){
        newsService.togglePreferredNews(withNews:news)
        newsView?.togglePreferredNews(withNews : news, andColor: UIColor.yellow)
    }
    
    func showNewsDetail(withNews news: News){
        newsView?.navigateToDetailNews(withNews: news)
        
    }
    
    func shareNews(withNews news: News){
        newsView?.shareNews(withNews: news)
    }
    
    func loadNews(withQueryString queryString: String?=nil){
        
        if let string = queryString{
            newsService?.searchNewses(withKeyword: string, onSuccess: displayNewsList)  
        } else {
            newsService?.all(onSuccess: displayNewsList)
        }
    }
    
    //MARK: - private methods
    
    func displayNewsList(withNewsList newsList : [News]){
                newsView?.displayNews(withNewsList: newsList)
    }
    
}
