//
//  NewsDetailView.swift
//  InUniPn
//
//  Created by Michele Bravo on 04/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation

protocol NewsDetailView: BaseView {
    
    func displayNews(withNews: News)
    
    func updateNewsDetailView(withNews: News)

    
}
