//
//  YJQGameViewModel.swift
//  DYZB
//
//  Created by yjq on 2018/3/23.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQGameViewModel {
    class func loadGameData(finishedCallBack:(()->())) {
        YJQNetworkTool.requestData3(.get, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName": "game"]) { (result) in
            guard let result = result as? [String : Any] else {return}
        }
    }
}
