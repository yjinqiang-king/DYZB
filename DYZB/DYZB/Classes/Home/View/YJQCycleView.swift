//
//  YJQCycleView.swift
//  DYZB
//
//  Created by yjq on 2018/3/20.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import SnapKit

private let kCycleCellID = "kCycleCellID"

class YJQCycleView: UIView {
    var cycleTimer: Timer?
    var model: [YJQCycleModel]? {
        didSet {
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = model?.count ?? 0
            // MARK: - 放在设置数据里面
            let indexPath = IndexPath(item: 6 * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeTimer()
            creatTimer()
        }
    }
    // MARK: - 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - lazy
    private lazy var collectionView: UICollectionView = {
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(YJQCycleCollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        return pageControl
    }()
}

// MARK: - UI
extension YJQCycleView {
    private func setupUI() {
        self.backgroundColor = UIColor.cyan
        self.addSubview(self.collectionView)
//        // MARK: - 放在设置数据里面
//        let indexPath = IndexPath(item: 6 * 100, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
//        removeTimer()
//        creatTimer()
        
//        self.collectionView.snp.makeConstraints { (make) in
//            make.edges.equalTo(self)
//        }
        self.addSubview(self.pageControl)
        self.pageControl.numberOfPages = 6
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(self)
        }
    }
}
// MARK: - UICollectionViewDataSource
extension YJQCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.model?.count ?? 0) * 10000
//        return 6 * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! YJQCycleCollectionViewCell
        cell.model = model?[indexPath.item % (model?.count)!]
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension YJQCycleView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        creatTimer()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + collectionView.bounds.width * 0.5
        
        self.pageControl.currentPage = Int(offsetX / collectionView.bounds.width) % (model?.count ?? 1)
//        self.pageControl.currentPage = Int(offsetX / collectionView.bounds.width) % 6
    }
}
// MARK: - 定时器
extension YJQCycleView {
    private func creatTimer(){
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    private func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let targetOffsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    }
}

