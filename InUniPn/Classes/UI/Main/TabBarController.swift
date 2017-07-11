//
//  ViewController.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

fileprivate struct ViewControllers {
    static let news = String(describing: NewsTableViewController.self)
    static let newsPosition = 0

    static let lessons = String(describing: LessonsViewController.self)
    static let lessonsPosition = 1

    static let profile = String(describing: ProfileViewController.self)
    static let profilePosition = 2
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// rimuovo i controller generati dalla storyboard
        self.viewControllers?.removeAll()

        self.tabBar.tintColor = .darkPrimaryColor
        
        /// associo il controller delle news
        let newsStoryboard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let newsViewController = newsStoryboard.instantiateViewController(withIdentifier: ViewControllers.news)
        self.viewControllers?.insert(newsViewController, at: ViewControllers.newsPosition)
        self.tabBar.items?[ViewControllers.newsPosition].title = Strings.news
        self.tabBar.items?[ViewControllers.newsPosition].image = #imageLiteral(resourceName: "ios-book-outline")
        
        
        /// associo il controller degli orari
        let lessonsStoryboard: UIStoryboard = UIStoryboard(name: "Lessons", bundle: nil)
        let lessonsViewController = lessonsStoryboard.instantiateViewController(withIdentifier: ViewControllers.lessons)
        self.viewControllers?.insert(lessonsViewController, at: ViewControllers.lessonsPosition)
        self.tabBar.items?[ViewControllers.lessonsPosition].title = Strings.lessons
        self.tabBar.items?[ViewControllers.lessonsPosition].image = #imageLiteral(resourceName: "ios-time-outline")

        /// associo il controller del profilo
        let profileStoryboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: ViewControllers.profile)
        self.viewControllers?.insert(profileViewController, at: ViewControllers.profilePosition)
        self.tabBar.items?[ViewControllers.profilePosition].title = Strings.profile
        self.tabBar.items?[ViewControllers.profilePosition].image = #imageLiteral(resourceName: "ios-person")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
