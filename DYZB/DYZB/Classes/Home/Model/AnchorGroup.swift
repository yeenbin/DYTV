//
//  AnchorGroup.swift
//  DYZB
//
//  Created by yoke on 2016/12/20.
//  Copyright © 2016年 yoke. All rights reserved.
//  每个组对应的直播房间数据的数组集合

import UIKit

class AnchorGroup: BaseGameModel {

    var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else {
                return
            }
            
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }

    ///组显示的图标
    var icon_name : String = "home_header_normal"
    
    ///定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    
}
