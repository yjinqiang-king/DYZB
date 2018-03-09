//
//  YJQPageContentView.swift
//  DYZB
//
//  Created by yjq on 2018/3/8.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
typealias scrollBlock = (CGFloat,Int,Int)->()
class YJQPageContentView: UIView {
    
    // MARK: - 定义属性
    private let CellIdentifier = "CellIdentifier"
    private var viewControllers: [UIViewController]
    private weak var parentVC: UIViewController?
    private var startOffsetX: CGFloat = 0
    private var currentOffsetX: CGFloat = 0
    var closure: scrollBlock?
    private var progress: CGFloat = 0
    private var sourceIndex: Int = 0
    private var targetIndex: Int = 0
    private var isForbidScrollDelegate: Bool = false
    // MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = {
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        return collectionView
    }()
    init(frame: CGRect, viewControllers: [UIViewController], parentController: UIViewController) {
        self.viewControllers = viewControllers
        self.parentVC = parentController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 设置UI
extension YJQPageContentView {
    private func setupUI() {
        for vc in viewControllers {
            parentVC?.addChildViewController(vc)
        }
        self.addSubview(collectionView)
        collectionView.frame = bounds
    }
}
// MARK: - collectionViewDataSource
extension YJQPageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewControllers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        //给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = viewControllers[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}
// MARK: - collectionViewDataSource
extension YJQPageContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断是否是点击事件
        if isForbidScrollDelegate {return}
        // 2.判断是左滑还是右滑
        currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= viewControllers.count {
                targetIndex = viewControllers.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= viewControllers.count {
                sourceIndex = viewControllers.count - 1
            }
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == -scrollViewW {
                progress = 1
                sourceIndex = targetIndex
            }
        }

        print("sourceIndex \(sourceIndex) targetIndex \(targetIndex) progress \(progress)")
        if (closure != nil) {
            closure!(progress,sourceIndex,targetIndex)
        }
    }
}
// MARK: - 外界可调用方法
extension YJQPageContentView {
    func pageScrollWithNumber(number: Int) {
        isForbidScrollDelegate = true
        
        let point = CGPoint(x: CGFloat(number) * kScreenWidth, y: 0)
        collectionView.setContentOffset(point, animated: false)
    }
}
