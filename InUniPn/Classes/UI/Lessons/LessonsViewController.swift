//
//  LessonsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class LessonsViewController:UITableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Orari", image: UIImage(named: "ios-time-outline"), tag: 1)
    }
    
}
