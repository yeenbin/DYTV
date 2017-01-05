//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by yoke on 2016/12/29.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}

extension AmuseViewModel {
    //加载娱乐的数据
    func loadAmuseData(finishedCallback : @escaping () -> ()){
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallback)
    }
}
