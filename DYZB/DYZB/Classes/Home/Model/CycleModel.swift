//
//  CycleModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/26.
//  Copyright © 2016年 yoke. All rights reserved.
//  循环播放的模型

import UIKit

class CycleModel: NSObject {
    //标题
    var title : String = ""
    //图片地址
    var pic_url : String = ""
    
    //主播信息对应的字典
    var room : [String : NSObject]? {
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    //主播信息对用的模型对象
    var anchor : AnchorModel?
    
    //MARK: - 自定义构造函数
    init(dic : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
