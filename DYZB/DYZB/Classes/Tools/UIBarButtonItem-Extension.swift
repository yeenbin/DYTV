//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by yoke on 2016/12/1.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

//MARK - 扩充便利构造方法

extension UIBarButtonItem {
    
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String, highImageName:String = "",size : CGSize = CGSize.zero,target :AnyObject? = nil, action : Selector? = nil ) {
        //1.创建button
        let btn = UIButton()
        //2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
             btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        //3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        btn.addTarget(target, action: action!, for: .touchUpInside)
        //创建UIBarButtonItem
        self.init(customView: btn)
    }
}
