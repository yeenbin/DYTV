//
//  NetworkTools.swift
//  DYZB
//
//  Created by yoke on 2016/12/20.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit
import Alamofire

//请求方式
enum  MethodType{
    case GET
    case POST
}

class NetworkTools {

}


// MARK: - 封装请求方法
extension NetworkTools {
    class func requestData(_ type : MethodType, urlString : String, parameters:[String : AnyObject], finishedCallback : @escaping (_ result : Any) -> ()) {
        
        //1.判断请求的方式
        let method = type == .GET ? Alamofire.HTTPMethod.get : Alamofire.HTTPMethod.post

        //2.请求网络数据
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            
            //3.获取结果
            guard let result = response.result.value else {
                print(response.result.error ?? "未知错误")
                return
            }
            
            finishedCallback(result)
        }

    }
}
