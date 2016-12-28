//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/22.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    //MARK: - 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    ///大数据主播群数据
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    ///颜值主播群数据
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    

}

//MARK: - 请求网络数据
extension RecommendViewModel {
    
    /// 请求推荐的数据
    ///
    /// - Parameter finishCallBack: 请求完毕后的回调
    func requestData(_ finishCallBack : @escaping ()-> ()){
        //1.定义参数
        let parameters = ["limit" : "4", "offset" : "0","time" : Date.getCurrentTime()]
        
        //2.创建group
        let group = DispatchGroup()
        
        //3.请求第一部分的推荐数据
        group.enter()//进入组
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            //3.1将result转化成字典类型 若不是字典类型就终止执行
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            //3.2根据data该key,获取字典数组 如若不是字典数组的类型就终止执行
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            
            //3.3遍历字典数组  转化成模型数组
            //3.3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_normal"
            
            //3.3.2 获取主播的信息
            for dic in dataArray {
                let anchor = AnchorModel(dict: dic)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            //3.4 离开组
            group.leave()
        }
        
        //4. 请求第二部分颜值的数据
        group.enter() //进入组
        
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //4.1 将result转化成字典
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            
            //4.2 根据data该key 获取直播的数据
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            //4.3 遍历字典数组 转化成模型数组
            //4.3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dic in dataArray {
                let anchor = AnchorModel(dict: dic)
                self.prettyGroup.anchors.append(anchor)
            }
            
            group.leave()
        }
        
        //5.请求部分游戏的数据
        group.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            group.leave()
        }
        
        //6.所有的数据请求完毕 做排序处理
        group.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
    }
    
    
    /// 请求无线轮播的数据
    ///
    /// - Parameter finishCallBack: 请求完毕后的回调
    func requestCycleData(_ finishCallBack : @escaping () -> ()){
        NetworkTools.requestData(.GET, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            
            //2.根据data的key取出数据
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else{
                return
            }
        
            //3.字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dic: dict))
            }
            
            finishCallBack()
        }
    }
}
