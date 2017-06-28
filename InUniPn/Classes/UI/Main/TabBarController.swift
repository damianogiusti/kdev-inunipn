//
//  ViewController.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// rimuovo i controller generati dalla storyboard
        self.viewControllers?.removeAll()
        
        /// associo il controller delle news
        let newsStoryboard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let newsViewController = newsStoryboard.instantiateViewController(withIdentifier: String(describing: NewsTableViewController.self)) as! NewsTableViewController
        self.viewControllers?.insert(newsViewController, at: 0)
        
        
        /// associo il controller degli orari
        let lessonsStoryboard: UIStoryboard = UIStoryboard(name: "Lessons", bundle: nil)
        let lessonsViewController = lessonsStoryboard.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
        self.viewControllers?.insert(lessonsViewController, at: 1)

        /// associo il controller del profilo
        let profileStoryboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.viewControllers?.insert(profileViewController, at: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
