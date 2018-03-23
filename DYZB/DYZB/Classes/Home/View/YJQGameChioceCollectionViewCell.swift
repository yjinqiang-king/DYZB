//
//  YJQGameChioceCollectionViewCell.swift
//  DYZB
//
//  Created by yjq on 2018/3/21.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class YJQGameChioceCollectionViewCell: UICollectionViewCell {
    var model: YJQRecommandHeaderModel? {
        didSet {
            let url = URL(string: (model?.icon_url)!)
            imgView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "home_more_btn"))
            nameLabel.text = model?.tag_name
        }
    }
    // MARK: - lazy属性
    private lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        let img = #imageLiteral(resourceName: "home_more_btn")
        imgView.image = img
        imgView.layer.cornerRadius = img.size.width / 2
        imgView.layer.masksToBounds = true
        return imgView
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "更多"
        return label
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
extension YJQGameChioceCollectionViewCell {
 
    private func setupUI() {
        backgroundColor = .white
        addSubview(self.imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset((self.bounds.width - 45) * 0.5)
            make.width.height.equalTo(45)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
    }
}
