//
//  DetailViewController.swift
//  InUniPn
//
//  Created by edward ilie on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, NewsDetailView {

    @IBOutlet weak var shareItem: UIBarButtonItem!
    @IBOutlet weak var saveItem: UIBarButtonItem!
    @IBOutlet weak var textContent: UITextView!
    @IBOutlet var titleLabel: UIView!
    @IBOutlet weak var imageDetail: UIImageView!
    
    private let newsDetailPresenter = NewsDetailPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        //titleLabel.tintColor = UIColor(red: 173, green: 34, blue: 34, alpha: 1)
        
        //saveItem.image= #imageLiteral(resourceName: "star_blank")
        //saveItem.image = #imageLiteral(resourceName: "star_yellow")
        //shareItem.image=#imageLiteral(resourceName: "share")
       
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayNews(withNews news: News) {
        print(news)
    }
    
    func updateNewsDetailView(withNews news : News) {
        
    }
    
    func showError(withError error : String) {
        
    }
    
    func showMessage(withMessage message : String) {
        
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }


}
