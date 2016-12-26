//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by yoke on 2016/12/22.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell : UICollectionViewCell {
    //MARK: - 控件属性
    @IBOutlet weak var iconImageView : UIImageView! //头像视图
    @IBOutlet weak var onlineBtn : UIButton! //在线人数按钮
    @IBOutlet weak var nickNameLabel : UILabel! //昵称文本框
    
    //AMRK: - 定义模型
    var anchor : AnchorModel? {
        didSet{
            //0.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            //1.取出在线人数显示
            var onlineStr : String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //3.设置封面的图片
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
