//
//  NewsView.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol NewsView: BaseView {

    func navigateToDetailNews(withNews: News);
    
    func shareNews(withNews : News);  
    
    func displayNews(withNewsList: [News]);
    
    func togglePreferredNews(withNews : News, andColor color : UIColor);
}
