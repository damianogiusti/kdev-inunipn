//
//  ProfileViewController.swift
//  InUniPn
//
//  Created by Michele Bravo on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var NameSurnameLabel: UILabel!
    @IBOutlet weak var UniversityLabel: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        UniversityLabel.textColor = UIColor.gray
        NameSurnameLabel.textColor = UIColor.black
        UserImage.layer.borderWidth = 0
        UserImage.layer.borderWidth = 2
        UserImage.layer.borderColor = UIColor.black.cgColor
        UserImage.layer.masksToBounds = false
        UserImage.layer.cornerRadius = UserImage.frame.height/2
        UserImage.clipsToBounds = true
        segment.setWidth(140, forSegmentAt: 0)
        segment.setWidth(140, forSegmentAt: 1)
        segment.backgroundColor = UIColor.gray
        segment.tintColor = UIColor.init(red: 178, green: 34, blue: 34, alpha: 1)
        
        segment.apportionsSegmentWidthsByContent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabBarController?.title = Strings.profile
    }
}

