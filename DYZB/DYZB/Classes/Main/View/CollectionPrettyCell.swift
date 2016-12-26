//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by yoke on 2016/12/23.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    //MARK: - 控件属性
    //所在城市的按钮
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK: - 定义模型的属性
    override var anchor: AnchorModel?{
        didSet{
            //1.将属性值传递给父类
            super.anchor = anchor
            
            //2.设置所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
