//
//  YJQTabBarViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/7.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.orange
        self.addChildVC(vc: YJQHomeViewController(), title: "首页", imgName: "btn_home")
        self.addChildVC(vc: YJQLiveViewController(), title: "直播", imgName: "btn_column")
        self.addChildVC(vc: YJQFollowViewController(), title: "点赞", imgName: "btn_live")
        self.addChildVC(vc: YJQProfileViewController(), title: "我的", imgName: "btn_user")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 添加子控制器
extension YJQTabBarViewController {
    private func addChildVC(vc: UIViewController, title: String?, imgName: String) {
        let navVC = YJQNaVViewController(rootViewController: vc)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imgName+"_normal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imgName+"_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.addChildViewController(navVC)
    }
}
