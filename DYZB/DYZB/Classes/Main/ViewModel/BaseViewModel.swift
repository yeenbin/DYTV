//
//  BaseViewModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/21.
//  Copyright © 2016 yoke. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


extension BaseViewModel {
    
    /// 加载主播的数据
    ///
    /// - Parameters:
    ///   - isGroupData: 是否为分组的数据
    ///   - URLString: 数据接口的位置
    ///   - parameters: 请求的参数
    ///   - finishedCallback: 请求后的回调
    ///  - @escaping  表示逃逸闭包
    func loadAnchorData(isGroupData : Bool,URLString : String, parameters : [String : Any]? = nil , finishedCallBack : @escaping  () -> ()) {
        
        NetworkTools.requestData(.GET, urlString: URLString, parameters: parameters) { (result) in
            //1.对界面进行处理
            guard let  resultDic = result as? [String : Any] else {
                return
            }
            
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {
                return
            }
            
            //2.判断是否为分组的数据
            if(isGroupData){
                //便利数组中的字典
                for dic in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dic))
                }
            }else{
                //2.1 创建组
                let group = AnchorGroup()
                
                for dic in dataArray{
                    group.anchors.append(AnchorModel(dict: dic))
                }
                
                self.anchorGroups.append(group)
            }
            
            //3.完成回调
            finishedCallBack()
        }
    }
}
