//
//  YJQRecommandHeaderModel.swift
//  DYZB
//
//  Created by yjq on 2018/3/19.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import ObjectMapper

class YJQRecommandHeaderModel: NSObject,Mappable {
    override init() {
        super.init()
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        tag_name <- map["tag_name"]
        small_icon_url <- map["small_icon_url"]
        room_list <- map["room_list"]
    }
    
    var tag_name: String = ""
    var small_icon_url: String = ""
    var room_list = [YJQRecommandModel]()
}
