//
//  YJQHomeViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/7.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 设置UI
extension YJQHomeViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor.cyan
        setupNavigationItem()
    }
    //设置导航栏的左右Item
    private func setupNavigationItem() {
        let size = CGSize(width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", normalImg: "logo", highlightedImg: "", size: CGSize.zero, target: self, action: #selector(logoItemClick), controlEvent: UIControlEvents.touchUpInside)
        let historyItem = UIBarButtonItem(title: "", normalImg: "image_my_history", highlightedImg: "Image_my_history_click", size: size, target: self, action: #selector(historyItemClick), controlEvent: UIControlEvents.touchUpInside)
        let searchItem = UIBarButtonItem(title: "", normalImg: "btn_search", highlightedImg: "btn_search_clicked", size: size, target: self, action: #selector(searchItemClick), controlEvent: UIControlEvents.touchUpInside)
        let scanItem = UIBarButtonItem(title: "", normalImg: "Image_scan", highlightedImg: "Image_scan_click", size: size, target: self, action: #selector(scanItemClick), controlEvent: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
    
}
// MARK: - 导航栏Item点击方法
extension YJQHomeViewController {
    @objc private func logoItemClick() {
        print("点击logoItem刷新页面")
    }
    @objc private func historyItemClick() {
        print("点击historyItem")
    }
    @objc private func searchItemClick() {
        print("点击searchItem")
    }
    @objc private func scanItemClick() {
        print("点击scanItem")
    }
}
