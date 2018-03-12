//
//  YJQRecommandViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/9.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50
private let kNormalCellIdentifier = "kNormalCellIdentifier"
private let kPrettyCellIdentifier = "kPrettyCellIdentifier"
private let kHeaderViewIdentifier = "kHeaderViewIdentifier"

class YJQRecommandViewController: UIViewController {
    // MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        //调整Item内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        //根据父控件的大小缩放
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(YJQNormalCollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellIdentifier)
        collectionView.register(YJQPrettyCollectionViewCell.self, forCellWithReuseIdentifier: kPrettyCellIdentifier)
        collectionView.register(YJQHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewIdentifier)
        return collectionView
    }()
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
// MARK: - UI
extension YJQRecommandViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}
// MARK: - 遵循UICollectionViewDataSource
extension YJQRecommandViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellIdentifier, for: indexPath)
        }else {
            cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellIdentifier, for: indexPath)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewIdentifier, for: indexPath)
        return headerView
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension YJQRecommandViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}
