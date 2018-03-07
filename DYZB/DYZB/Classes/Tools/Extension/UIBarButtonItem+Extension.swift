//
//  UIBarButtonItem+Extension.swift
//  DYZB
//
//  Created by yjq on 2018/3/7.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //构造函数必须使用convenience 并且在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(title: String?, normalImg: String, highlightedImg: String = "", size: CGSize = CGSize.zero, target: Any?, action: Selector, controlEvent: UIControlEvents) {
        let btn = UIButton()
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else {
           btn.sizeToFit()
        }
        if title != nil && title != "" {
            btn.setTitle(title, for: UIControlState.normal)
        }
        btn.setImage(UIImage(named: normalImg), for: .normal)
        if highlightedImg != "" {
            btn.setImage(UIImage(named: highlightedImg), for: .highlighted)
        }
        btn.addTarget(target, action: action, for: controlEvent)
        self.init(customView: btn)
    }
}
