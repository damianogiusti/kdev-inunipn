//
//  NewsTableViewCell.swift
//  InUniPn
//
//  Created by Damiano Giusti on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var mainView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!

    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    private var cornerRadius: CGFloat = 2
    private var shadowOffsetWidth: Int = 0
    private var shadowOffsetHeight: Int = 3
    private var shadowColor: UIColor? = .black
    private var shadowOpacity: Float = 0.5

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
