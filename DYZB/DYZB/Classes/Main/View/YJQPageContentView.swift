//
//  YJQPageContentView.swift
//  DYZB
//
//  Created by yjq on 2018/3/8.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQPageContentView: UIView {

    // MARK: - 定义属性
    private let CellIdentifier = "CellIdentifier"
    private var viewControllers: [UIViewController]
    private weak var parentVC: UIViewController?
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
}
