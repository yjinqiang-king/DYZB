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
    private let kScrollLineH: CGFloat = 2
    // MARK: - 懒加载
    private lazy var labels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    // MARK: - 定义属性
    private var titles:[String]
    //记录被选中的label的下标
    private var currentIndex: Int
    var pageTitleViewClosure:((Int)->())?
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        self.currentIndex = 0
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
        setupLabels()
        //添加scrollLineView、BottomLineView
        setupScrollLineViewBottomLine()
    }
    private func setupLabels() {
        let labelY: CGFloat = 0
        //        let labelW: CGFloat = self.bounds.size.width / CGFloat(titles.count)
        let labelW: CGFloat = self.bounds.size.width / 4.0
        let labelH: CGFloat = self.bounds.size.height - kScrollLineH
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            //开启label的可交互
            label.isUserInteractionEnabled = true
            //添加lable的点击手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelClick(gesture:)))
            label.addGestureRecognizer(tap)
            
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.text = title
            label.tag = index
            if index == 0 {
                label.textColor = UIColor(r: kSelectedColcor.0, g: kSelectedColcor.1, b: kSelectedColcor.2, alpha: 1.0)
            } else {
                label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
            }
            let labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            self.labels.append(label)
        }
        scrollView.contentSize = CGSize(width: labelW * CGFloat(titles.count), height: labelH)
    }
    private func setupScrollLineViewBottomLine() {
        //bottomView
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        let bottomLineH: CGFloat = 0.5
        self.addSubview(bottomLine)
        self.addSubview(scrollLineView)
        //获取第一个label
        guard let fisrtLabel = labels.first else {
            return
        }
        let bottomLineFrame = CGRect(x: 0, y: self.bounds.height - bottomLineH, width: kScreenWidth, height: bottomLineH)
        bottomLine.frame = bottomLineFrame
        let scrollLineFrame = CGRect(x: fisrtLabel.frame.origin.x, y: self.bounds.height - kScrollLineH, width: fisrtLabel.bounds.width, height: kScrollLineH)
        scrollLineView.frame = scrollLineFrame
    }
}
// MARK: - label手势方法
extension YJQPageTitleView {
    @objc private func labelClick(gesture:UIGestureRecognizer) {
        let label = gesture.view as! UILabel
        let beforeLabel = labels[currentIndex]
        beforeLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1.0)
        label.textColor = UIColor(r: kSelectedColcor.0, g: kSelectedColcor.1, b: kSelectedColcor.2, alpha: 1.0)
        currentIndex = label.tag
        UIView.animate(withDuration: 0.1) {
            self.scrollLineView.frame.origin.x += label.bounds.width * CGFloat(self.currentIndex - beforeLabel.tag)
        }
        if pageTitleViewClosure != nil {
            pageTitleViewClosure!(currentIndex)
        }
    }
}
// MARK: - 用于外界调用的方法
extension YJQPageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        let colorScale = (kSelectedColcor.0 - kNormalColor.0, kSelectedColcor.1 - kNormalColor.1, kSelectedColcor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColcor.0 - colorScale.0 * progress, g: kSelectedColcor.1 - colorScale.1 * progress, b: kSelectedColcor.2 - colorScale.2 * progress, alpha: 1.0)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorScale.0 * progress, g: kNormalColor.1 + colorScale.1 * progress, b: kNormalColor.2 + colorScale.2 * progress, alpha: 1.0)
        
        scrollLineView.frame.origin.x = sourceLabel.frame.origin.x + moveTotalX * progress
        
        currentIndex = targetIndex
    }
}
