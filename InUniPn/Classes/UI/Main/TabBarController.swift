//
//  ViewController.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

enum Tabs:Int {
    case news,lessons,profile
}

let tabsNumber = Range<Int>(0..<3)


class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        /// rimuovo i controller generati dalla storyboard
        self.viewControllers?.removeAll()
        
        /// associo il controller delle news
        let newsStoryboard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let newsViewController = newsStoryboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        self.viewControllers?.insert(newsViewController, at: 0)
        
        
        /// associo il controller degli orari
        let lessonsStoryboard: UIStoryboard = UIStoryboard(name: "Lessons", bundle: nil)
        let lessonsViewController = lessonsStoryboard.instantiateViewController(withIdentifier: "LessonsViewController") as! LessonsViewController
        self.viewControllers?.insert(lessonsViewController, at: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
