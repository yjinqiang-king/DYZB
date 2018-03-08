//
//  YJQPageTitleView.swift
//  DYZB
//
//  Created by yjq on 2018/3/7.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQPageTitleView: UIView {
    // MARK: - 定义常量
    private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85,85,85)
    private let kSelectedColcor: (CGFloat, CGFloat, CGFloat) = (225,128,0)
    private let KScrollLineH: CGFloat = 2
    // MARK: - 懒加载
    private lazy var labels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    // MARK: - 定义属性
    private var titles:[String]
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 设置UI界面
extension YJQPageTitleView {
    private func setupUI() {
        self.addSubview(scrollView)
        //逐个添加label
        let labelY: CGFloat = 0
//        let labelW: CGFloat = self.bounds.size.width / CGFloat(titles.count)
        let labelW: CGFloat = self.bounds.size.width / 4.0
        let labelH: CGFloat = self.bounds.size.height - KScrollLineH
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
            let labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            self.labels.append(label)
        }
        scrollView.contentSize = CGSize(width: labelW * CGFloat(titles.count), height: labelH)
    }
}
