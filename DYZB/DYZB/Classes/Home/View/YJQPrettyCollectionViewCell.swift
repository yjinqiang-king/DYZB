//
//  YJQPrettyCollectionViewCell.swift
//  DYZB
//
//  Created by yjq on 2018/3/12.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQPrettyCollectionViewCell: UICollectionViewCell {
    // MARK: - 懒加载属性
    private lazy var bigImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "live_cell_default_phone")
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "666在线"
        label.backgroundColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.5)
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "学习共享资源"
        return label
    }()
    
    private lazy var mapImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ico_location")
        return imgView
    }()
    
    private lazy var mapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "北京市"
        return label
    }()
    // MARK: - 系统Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension YJQPrettyCollectionViewCell {
    private func setupUI() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.mapImgView)
        self.mapImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)
            make.height.width.equalTo(14)
        }
        self.contentView.addSubview(self.mapLabel)
        self.mapLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.mapImgView.snp.right).offset(5)
            make.centerY.equalTo(self.mapImgView)
        }
        self.contentView.addSubview(self.tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.mapImgView.snp.top).offset(-5)
            make.left.equalTo(self.mapImgView)
            make.right.equalTo(self.contentView).offset(-5)
            make.height.equalTo(15)
        }
        self.contentView.addSubview(self.bigImgView)
        self.bigImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.tipLabel.snp.top).offset(-5)
        }
        self.bigImgView.addSubview(self.numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.bigImgView).offset(5)
            make.right.equalTo(self.bigImgView).offset(-5)
            make.height.equalTo(16)
        }
    }
}
