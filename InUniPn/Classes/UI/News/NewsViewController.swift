//
//  NewsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsViewController:UITableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "ios-book-outline"), tag: 0)
    }
    
}
