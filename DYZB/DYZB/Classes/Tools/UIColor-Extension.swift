//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by yoke on 2016/12/5.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

extension UIColor {
    //添加新的初始化方法
    convenience init(r : CGFloat, g : CGFloat , b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    //生成随机颜色的方法
    func randomColor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
