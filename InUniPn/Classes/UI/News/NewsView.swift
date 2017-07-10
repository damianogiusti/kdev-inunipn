//
//  NewsView.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import UIKit


protocol NewsView: BaseView {

    func navigateToDetailNews(withNews: News)

    func displayNews(withNewsList: [News])

    func updateNewsView(news: News, atIndex index: Int)
    

    func shareNews(activity : UIActivityViewController)
}
