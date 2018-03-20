
//
//  YJQRecommandViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/9.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import Alamofire

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kCycleViewH: CGFloat = kScreenWidth * 3 / 8
private let kHeaderViewH: CGFloat = 50
private let kNormalCellIdentifier = "kNormalCellIdentifier"
private let kPrettyCellIdentifier = "kPrettyCellIdentifier"
private let kHeaderViewIdentifier = "kHeaderViewIdentifier"

class YJQRecommandViewController: UIViewController {
    
    // MARK: - 懒加载属性
    private lazy var cycleView: YJQCycleView = {
        let cycleView = YJQCycleView(frame: CGRect(x: 0, y: -kCycleViewH, width: kScreenWidth, height: kCycleViewH))
        return cycleView
    }()
    private let recommandVM = YJQRecommandViewModel()
    private lazy var hotArr:NSArray = {
        let arr = NSArray()
        return arr
    }()
    private lazy var faceArr:NSArray = {
        let arr = NSArray()
        return arr
    }()
    private lazy var headerArr:NSArray = {
        let arr = NSArray()
        return arr
    }()

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
        // 设置contentInset
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH, 0, 0, 0)
        //根据父控件的大小缩放
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(YJQNormalCollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellIdentifier)
        collectionView.register(YJQPrettyCollectionViewCell.self, forCellWithReuseIdentifier: kPrettyCellIdentifier)
        collectionView.register(YJQHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewIdentifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
// MARK: - 网络数据加载
extension YJQRecommandViewController {
    private func loadData() {
        YJQRecommandViewModel().requestData { (arr) in
            if arr.count > 0 {
            self.hotArr = arr[0] as! NSArray
            self.faceArr = arr[1] as! NSArray
            self.headerArr = arr[2] as! NSArray
            }
            self.collectionView.reloadData()
        }
        loadCycleData()
    }
    // 加载cycleView的数据
    private func loadCycleData() {
        YJQRecommandViewModel().loadCycleData {
            self.cycleView.model = self.recommandVM.cycleModels
        }
    }
}
// MARK: - UI
extension YJQRecommandViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.addSubview(cycleView)
    }
}
// MARK: - 遵循UICollectionViewDataSource
extension YJQRecommandViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.headerArr.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.hotArr.count
        }else if(section >= 2) {
            let json = self.headerArr[section] as? YJQRecommandHeaderModel
            return (json?.room_list.count)!
        }else {
        return self.faceArr.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellIdentifier, for: indexPath) as! YJQPrettyCollectionViewCell
            cell.faceInfo = self.faceArr[indexPath.item] as? YJQRecommandModel
            return cell
        }else {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellIdentifier, for: indexPath) as! YJQNormalCollectionViewCell
            if indexPath.section == 0 {
                cell.hotInfo = self.hotArr[indexPath.item] as? YJQRecommandModel
            }else {
            let json = self.headerArr[indexPath.section] as? YJQRecommandHeaderModel
                cell.hotInfo = json?.room_list[indexPath.item]
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewIdentifier, for: indexPath) as! YJQHeaderCollectionReusableView
        headerView.modelInfo = self.headerArr[indexPath.section] as? YJQRecommandHeaderModel
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
