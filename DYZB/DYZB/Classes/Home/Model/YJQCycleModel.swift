//
//  YJQCycleModel.swift
//  DYZB
//
//  Created by yjq on 2018/3/20.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import ObjectMapper

class YJQCycleModel: NSObject,Mappable {
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        pic_url <- map["pic_url"]
    }
    var title: String?
    var pic_url: String?
}
