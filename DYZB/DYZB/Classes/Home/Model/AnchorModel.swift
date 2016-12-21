//
//  AnchorModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/20.
//  Copyright © 2016年 yoke. All rights reserved.
//  直播房间的信息模型

import UIKit

class AnchorModel: NSObject {
    //房间id
    var room_id : Int = 0
    //房间图片URLString
    var vertical_src : String = ""
    //0.电脑直播 1.手机直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播名称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
