//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/20.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit


class RecommendViewModel: NSObject {
    // AnchorGroup 组成的二维数组
    lazy var  anchorGroups = [AnchorGroup]()

    private lazy var hotAnchorGroup = AnchorGroup()
    
    private lazy var prettyAnchorGroup = AnchorGroup()
    
}

extension RecommendViewModel {
//    func requestRecommendData(RecommendDataCallback : () -> ()) {
//        // 0.定义处理闭包
//        func parserData(result : AnyObject) -> [[String : NSObject]]? {
//            // 1.将结果转成字典
//            guard let resultDict = result as? [String : NSObject] else { return nil }
//            // 2.通过data的key取出对应的数组
//            return resultDict["data"] as? [[String : NSObject]]
//        }
//        // 1.请求热门数据
//        let group = DispatchGroup()
//        group.enter()
//        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getNowTimeString()]) { (result) in
//            // 1.获取解析的字典数据
//            guard let dictArray = parserData(result) else { return }
//            // 2.创建对象
//            self.hotAnchorGroup.tag_name = "热门"
//            self.hotAnchorGroup.icon_name = "home_header_hot"
//            var tempArray = [AnchorModel]()
//            for dict in dictArray {
//                tempArray.append(AnchorModel(dict: dict))
//            }
//            self.hotAnchorGroup.anchors = tempArray
//            dispatch_group_leave(group)
//        }
//        // 2.请求颜值数据
//        dispatch_group_enter(group)
//        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit":"4", "offset" : "0", "time" : NSDate.getNowTimeString()]) { (result) in
//            // 1.获取解析的字典数据
//            guard let dictArray = parserData(result) else { return }
//            // 2.创建对象
//            self.prettyAnchorGroup.tag_name = "颜值"
//            self.prettyAnchorGroup.icon_name = "home_header_phone"
//            var tempArray = [AnchorModel]()
//            for dict in dictArray {
//                tempArray.append(AnchorModel(dict: dict))
//            }
//            self.prettyAnchorGroup.anchors = tempArray
//            dispatch_group_leave(group)
//        }
//        // 3.请求游戏数据
//        dispatch_group_enter(group)
//        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4", "offset" : "0", "time" : NSDate.getNowTimeString()]) { (result) in
//            // 1.获取解析的字典数据
//            guard let dictArray = parserData(result) else { return }
//            // 2.解析数据
//            for dict in dictArray {
//                self.anchorGroups.append(AnchorGroup(dict: dict))
//            }
//            dispatch_group_leave(group)
//        }
//        // 4.所有数据加载完成
//        dispatch_group_notify(group, dispatch_get_main_queue()) {
//            self.anchorGroups.insert(self.prettyAnchorGroup, atIndex: 0)
//            self.anchorGroups.insert(self.hotAnchorGroup, atIndex: 0)
//            RecommendDataCallback()
//        }
//    }
}

