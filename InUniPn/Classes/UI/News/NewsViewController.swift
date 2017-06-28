//
//  NewsViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var contentTextView: UILabel!

    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "News", image: #imageLiteral(resourceName: "ios-book-outline"), tag: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
