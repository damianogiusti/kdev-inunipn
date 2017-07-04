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
    static let lessons = String(describing: LessonsViewController.self)
    static let profile = String(describing: ProfileViewController.self)
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// rimuovo i controller generati dalla storyboard
        self.viewControllers?.removeAll()

        /// associo il controller delle news
        let newsStoryboard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let newsViewController = newsStoryboard.instantiateViewController(withIdentifier: ViewControllers.news)
        self.viewControllers?.insert(newsViewController, at: 0)
        self.tabBar.items?[0].title = Strings.news
        self.tabBar.items?[0].image = #imageLiteral(resourceName: "ios-book-outline")
        
        
        /// associo il controller degli orari
        let lessonsStoryboard: UIStoryboard = UIStoryboard(name: "Lessons", bundle: nil)
        let lessonsViewController = lessonsStoryboard.instantiateViewController(withIdentifier: ViewControllers.lessons)
        self.viewControllers?.insert(lessonsViewController, at: 1)
        self.tabBar.items?[1].title = Strings.lessons
        self.tabBar.items?[1].image = #imageLiteral(resourceName: "ios-time-outline")

        /// associo il controller del profilo
        let profileStoryboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: ViewControllers.profile)
        self.viewControllers?.insert(profileViewController, at: 2)
        self.tabBar.items?[2].title = Strings.profile
        self.tabBar.items?[2].image = #imageLiteral(resourceName: "ios-person")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
