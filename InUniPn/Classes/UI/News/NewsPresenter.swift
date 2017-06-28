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
    
    private var newsService : NewsInMemoryDatasource = NewsInMemoryDatasource()
    
    private let userService : UserService = UserService()
    
    //MARK: - view
    
    private var newsView : NewsView? 
    
    //MARK: - lifecycle methods
    
    func create(withView view: NewsView) {
        newsView = view
    }
    
    //MARK: - user interaction methods
    
    
    
    //MARK: - private methods
    


    
}
