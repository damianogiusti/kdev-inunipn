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
    
    //    private var newsService
    
    private let userService : UserService = UserService()
    
    //MARK: - view
    
    private var newsView : NewsView? 
    
    //MARK: - lifecycle methods
    
    func create(withView view: NewsView) {
        newsView = view
    }
    
    //MARK: - user interaction methods
    
    func showLessonsView(){
        newsView?.navigateToLessons()
    }
    
    func showProfile(){
        newsView?.navigateToProfile()
    }
    
    func togglePreferredNews(withNews news: News){
        //newsService.togglePreferredNews(withNews:news)
        newsView?.togglePreferredNews(withNews : news, andColor: UIColor.yellow)
    }
    
    func showNewsDetail(withNews news: News){
        newsView?.navigateToDetailNews(withNews: news)
        
    }
    
    func shareNews(withNews news: News){
        newsView?.shareNews(withNews: news)
    }
    
    func loadNews(withQueryString queryString: String?=nil){
        
        let newsList : [News]
        
        if let _ = queryString{
            //newsList = newsService.getAllNews()
        } else {
            //newsList = newService.search(queryString)
        }
        
      //  newsView?.displayNews(withNewsList: newsList)
    }
    
    //MARK: - private methods
        
    
}
