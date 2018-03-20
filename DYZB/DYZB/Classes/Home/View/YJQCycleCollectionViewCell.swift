//
//  YJQCycleCollectionViewCell.swift
//  DYZB
//
//  Created by yjq on 2018/3/20.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class YJQCycleCollectionViewCell: UICollectionViewCell {
    //设置数据
    var model: YJQCycleModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.iconImg.kf.setImage(with: URL(string: (model?.pic_url)!), placeholder: UIImage(named: "Img_default"))
        }
    }
    // MARK: - lazy
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "标题"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var iconImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Img_default")
        imgView.contentMode = .scaleAspectFill
        return imgView
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
// MARK: - UI
extension YJQCycleCollectionViewCell {
    private func setupUI() {
        self.contentView.addSubview(self.iconImg)
        self.iconImg.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        self.iconImg.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self.iconImg)
        }
    }
}
