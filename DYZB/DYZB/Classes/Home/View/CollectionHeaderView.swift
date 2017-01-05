//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by yoke on 2016/12/13.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    //MARK: - 定义属性值
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_url ?? "home_header_normal")
        }
    }
    
}


//MARK: - 从xib中快速创建的方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
