//
//  NSDate+Extension.swift
//  DYZB
//
//  Created by yjq on 2018/3/13.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentDate() -> String {
        let date = Date()
        let dateTemp = Int(date.timeIntervalSince1970)
        return("\(dateTemp)")
    }
}
