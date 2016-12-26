//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by yoke on 2016/12/22.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    //房间的名称
    @IBOutlet weak var roomLabel: UILabel!
    
    //MARK: - 定义模型属性
    override var anchor: AnchorModel? {
        didSet{
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.房间的名称
            roomLabel.text = anchor?.room_name
        }
    }

}
