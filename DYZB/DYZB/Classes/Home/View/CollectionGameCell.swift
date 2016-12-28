//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by yoke on 2016/12/27.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    
    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 定义模型属性
    var game : BaseGameModel? {
        didSet {
            titleLabel.text = game?.tag_name
            if let iconURL = URL(string: game?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            }else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
        iconImageView.layer.masksToBounds = true
    }
}
