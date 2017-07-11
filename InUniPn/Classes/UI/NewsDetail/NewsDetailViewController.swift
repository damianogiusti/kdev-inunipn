//
//  DetailViewController.swift
//  InUniPn
//
//  Created by edward ilie on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol NewsDetailViewControllerDelegate: class {
    func shareNewsDetail(withNews: News)
    func favouriteNews(withNews: News)
}

class NewsDetailViewController: UIViewController, NewsDetailView {
    
    weak var delegate:NewsDetailViewControllerDelegate?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet weak var newsContent: UITextView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    private let newsDetailPresenter = NewsDetailPresenter()
    
    public var news : News?
    
    private let placeholderImage = "https://bytesizemoments.com/wp-content/uploads/2014/04/placeholder.png"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        newsDetailPresenter.create(withView: self)
        newsDetailPresenter.displayNews(withNews: news!)
        newsTitle.text = news?.title
        newsTitle.textColor = .accentColor
        newsContent.text = news?.content
        newsImage.sd_setImage(with: URL(string: news?.imageUrl ?? placeholderImage))
        newsDate.text = formatDate(date: (news?.createdDate)!)
        
        if (news?.starred)! {
            favouriteButton.setImage(#imageLiteral(resourceName: "ios-star"), for: .normal)
        } else {
            favouriteButton.setImage(#imageLiteral(resourceName: "ios-star-outline"), for: .normal)
        }
    }
    
    
    fileprivate func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee',' dd'/'MM'/'yyyy"
        dateFormatter.locale = Calendar.current.locale
        return dateFormatter.string(from: date)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            let orient = UIApplication.shared.statusBarOrientation
            switch orient {
            case .portrait:
            // Do something
                break
            default:
            // Do something else
                break
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.newsContent.setContentOffset(CGPoint.zero, animated: true)
        })
        
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newsContent.setContentOffset(CGPoint.zero, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFavouriteButtonPressed(_ sender: UIButton) {
        if (news?.starred)! {
            favouriteButton.setImage(#imageLiteral(resourceName: "ios-star-outline"), for: .normal)
        } else {
            favouriteButton.setImage(#imageLiteral(resourceName: "ios-star"), for: .normal)
        }
        delegate?.favouriteNews(withNews: news!)
    }
    
    @IBAction func onShareButtonPressed(_ sender: UIButton) {
        delegate?.shareNewsDetail(withNews: news!)
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
