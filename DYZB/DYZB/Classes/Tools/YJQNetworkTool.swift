//
//  YJQNetworkTool.swift
//  DYZB
//
//  Created by yjq on 2018/3/12.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class YJQNetworkTool {

    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString,method: method,parameters:parameters)
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
    class func requestData3(_ type: MethodType, url: String, parameters: [String : Any]? = nil,encoding:ParameterEncoding? = URLEncoding.default,headers: HTTPHeaders? = nil, finishedCallBack: @escaping(_ result: Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post

        Alamofire.request(url,method: method,parameters: parameters,encoding:URLEncoding.default, headers:nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallBack(result)
        }

    }
}
