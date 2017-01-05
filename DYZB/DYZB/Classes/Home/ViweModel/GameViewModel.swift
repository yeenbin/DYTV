//
//  GameViewModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/28.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class GameViewModel {
    //装载gameModel的数组
    var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishCallback: @escaping ()->()) {
        NetworkTools.requestData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            //1.获取到数据
            guard let resultDic = result as? [String : Any] else{
                return
            }
            
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {
                return
            }
            
            //2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            //3.成功后的回调
            finishCallback()
        }
    }
}
