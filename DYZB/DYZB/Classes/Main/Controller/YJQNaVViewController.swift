//
//  YJQNaVViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/7.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQNaVViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var count: UInt32 = 0
        let ivarList = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivarList![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString : name!))
        }
        guard let systermGest = interactivePopGestureRecognizer else {return}
        let gestView = systermGest.view
        let targets = systermGest.value(forKey: "_targets") as? [NSObject]
        guard let targetObjct = targets?.first else {
            return
        }
        guard let target = targetObjct.value(forKey: "target") else{return}
        let act = Selector(("handleNavigationTransition:"))
        let pan = UIPanGestureRecognizer(target: target, action: act)
        gestView?.addGestureRecognizer(pan)
        // Do any additional setup after loading the view.
    }
    // MARK: --跳转控制器隐藏tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
