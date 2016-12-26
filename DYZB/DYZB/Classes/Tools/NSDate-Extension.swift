//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by yoke on 2016/12/22.
//  Copyright © 2016年 yoke. All rights reserved.
//

import Foundation

extension Date {
    
    /// 获取当前时间戳
    /// 静态方法为类可调用
    /// - Returns: 返回时间戳的字符串
   static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
