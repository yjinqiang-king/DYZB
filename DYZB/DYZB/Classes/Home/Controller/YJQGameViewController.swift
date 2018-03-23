//
//  YJQGameViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/21.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

private let kEdgsMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenWidth - 2 * kEdgsMargin) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let kGameCellID: String = "kGameCellID"

class YJQGameViewController: UIViewController {
    // MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = {
        //创建layouot
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgsMargin, 0, kEdgsMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(YJQGameChioceCollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        return collectionView
    }()
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - 设置UI
extension YJQGameViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .yellow
        view.addSubview(self.collectionView)
    }
}

// MARK: - 实现UICollectionView的数据源
extension YJQGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! YJQGameChioceCollectionViewCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
