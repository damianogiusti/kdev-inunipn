//
//  ProfileViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    ///associo il tab item al controller
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Profilo", image: UIImage(named: "ios-person"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabBarController?.title = Strings.profile
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
