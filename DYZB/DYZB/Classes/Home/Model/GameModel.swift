//
//  GameModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/20.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class GameModel: NSObject {

    //MARK: - 定义属性
    var tag_name : String = ""
    
    var icon_url : String = ""
    
    
    //MARK: - 自定义构造函数
    override init(){
        
    }
    
    init(dict : [String : Any]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
