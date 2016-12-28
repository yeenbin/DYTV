//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by yoke on 2016/12/26.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    //MARK: - 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 定义模型的属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")!
            
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"))
        }
    }
}
