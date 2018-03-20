//
//  YJQRecommandViewModel.swift
//  DYZB
//
//  Created by yjq on 2018/3/13.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import ObjectMapper

class YJQRecommandViewModel {
    private var dataArray: NSMutableArray = NSMutableArray()
    private var hotArray: NSMutableArray = NSMutableArray()
    private var faceArray: NSMutableArray = NSMutableArray()
    private var headerArray: NSMutableArray = NSMutableArray()
    lazy var cycleModels: [YJQCycleModel] = [YJQCycleModel]()
}
// MARK: - 发送网络请求
extension YJQRecommandViewModel {
    
    func loadOtherData(isHeaderPart: Bool, url: String, parameters: [String : Any], finishedCallBack:((_ arr: NSArray)->())) {
        YJQNetworkTool.requestData3(.get, url: url, parameters: parameters, encoding: nil, headers: nil) { (result) in
            guard let dataResult = result as? [String : NSObject] else{return}
            guard let dataArr = dataResult["data"] as? [[String: NSObject]] else{return}
            if isHeaderPart {
                let model1 = YJQRecommandHeaderModel()
                model1.tag_name = "热门"
                model1.small_icon_url = "home_header_hot"
                self.headerArray.add(model1)
                let model2 = YJQRecommandHeaderModel()
                model2.tag_name = "颜值"
                model2.small_icon_url = "home_header_phone"
                self.headerArray.add(model2)
                for json in dataArr {
                    guard let model = Mapper<YJQRecommandHeaderModel>().map(JSON: json)else {return}
                    self.headerArray.add(model)
                }
            }
        }
        finishedCallBack(self.headerArray)
    }

    func requestData( finishedCallBack: @escaping (_ arr: NSArray)->() ) {
        let date = Date.getCurrentDate()
        let parameters = ["limit":"4", "offset":"0", "time":date]
        
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        YJQNetworkTool.requestData3(.get, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters, encoding: nil, headers: nil) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dateArr = resultDict["data"] as? [[String : Any]] else {return}
            for json in dateArr {
                guard let model = Mapper<YJQRecommandModel>().map(JSON: json) else {return}
                self.hotArray.add(model)
            }
            dGroup.leave()
        }

        dGroup.enter()
        YJQNetworkTool.requestData3(.get, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, encoding: nil, headers: nil) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dateArr = resultDict["data"] as? [[String : NSObject]] else {return}
            for json in dateArr {
                guard let model = Mapper<YJQRecommandModel>().map(JSON: json) else {return}
                self.faceArray.add(model)
            }
            dGroup.leave()
        }
        
        dGroup.enter()
        loadOtherData(isHeaderPart: true, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {_ in
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.dataArray.insert(self.headerArray, at: 0)
            self.dataArray.insert(self.faceArray, at: 0)
            self.dataArray.insert(self.hotArray, at: 0)
            finishedCallBack(self.dataArray.copy() as! NSArray)
        }
    }
    
    func loadCycleData(finishedCallBack:@escaping (()->())) {
        YJQNetworkTool.requestData3(.get, url: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version": "2.300"], encoding: nil, headers: nil) { (result) in
            guard let resultDict = result as? [String: NSObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String: Any]] else {return}
            for json in dataArr {
                guard let model = Mapper<YJQCycleModel>().map(JSON: json) else {return}
                self.cycleModels.append(model)
            }
            finishedCallBack()
        }
    }
}
