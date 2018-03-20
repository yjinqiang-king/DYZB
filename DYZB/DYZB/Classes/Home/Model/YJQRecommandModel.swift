//
//  YJQRecommandModel.swift
//  DYZB
//
//  Created by yjq on 2018/3/13.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import ObjectMapper

class YJQRecommandModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        room_id <- map["room_id"]
        vertical_src <- map["vertical_src"]
        isVertical <- map["isVertical"]
        room_name <- map["room_name"]
        nickname <- map["nickname"]
        online <- map["online"]
        anchor_city <- map["anchor_city"]
    }
    
    /// 房间ID
    var room_id : String = ""
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int?
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : String?
    /// 所在城市
    var anchor_city : String = ""
}


