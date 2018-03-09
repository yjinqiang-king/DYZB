//
//  YJQHeaderCollectionReusableView.swift
//  DYZB
//
//  Created by yjq on 2018/3/9.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQHeaderCollectionReusableView: UICollectionReusableView {
    // MARK: - 懒加载属性
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    private lazy var icon: UIImageView = {
        let imgView = UIImageView(image: UIImage(named:))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - UI
extension YJQHeaderCollectionReusableView {
    private func setupUI() {
        
    }
}
