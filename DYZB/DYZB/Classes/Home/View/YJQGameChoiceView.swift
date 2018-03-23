//
//  YJQGameChoiceView.swift
//  DYZB
//
//  Created by yjq on 2018/3/21.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

private let kItemW: CGFloat = 80
private let kGameChoiceCellID = "kGameChoiceCellID"

class YJQGameChoiceView: UIView {
    // MARK: - 定义属性
    var gameChoiceModels: [YJQRecommandHeaderModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    // MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: self.bounds.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(YJQGameChioceCollectionViewCell.self, forCellWithReuseIdentifier: kGameChoiceCellID)
        return collectionView
    }()
    // MARK: - 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI
extension YJQGameChoiceView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(self.collectionView)
    }
}

// MARK: - 实现UICollectionView的数据源
extension YJQGameChoiceView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameChoiceModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameChoiceCellID, for: indexPath) as! YJQGameChioceCollectionViewCell
        cell.model = self.gameChoiceModels?[indexPath.item]
        return cell
    }
}
