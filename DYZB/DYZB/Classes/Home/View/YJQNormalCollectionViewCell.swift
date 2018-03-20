//
//  YJQNormalCollectionViewCell.swift
//  DYZB
//
//  Created by yjq on 2018/3/12.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQNormalCollectionViewCell: UICollectionViewCell {
    
    var hotInfo: YJQRecommandModel? {
        didSet {
            guard let info = hotInfo else {
                return
            }
            let url = URL(string: info.vertical_src)
            bigImgView.kf.setImage(with: url, placeholder: UIImage(named: "home_live_cate_normal"))
            nameLable.text = info.nickname
            numberLabel.text = info.online ?? "" + "在线"
            tipLabel.text = info.room_name
        }
    }
    // MARK: - 懒加载属性
    private lazy var bigImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Img_default")
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .white
        label.text = "学习网络资源"
        return label
    }()
    
    private lazy var personImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Image_online")
        return imgView
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .white
        label.text = "666人在线"
        return label
    }()
    
    private lazy var smallImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "home_live_cate_normal")
        return imgView
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "学习网络共享资源"
        return label
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
extension YJQNormalCollectionViewCell {
    private func setupUI() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.smallImgView)
        self.smallImgView.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(-5)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        self.contentView.addSubview(self.tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.smallImgView.snp.right).offset(5)
            make.centerY.height.equalTo(self.smallImgView)
            make.right.equalTo(self)
        }
        self.contentView.addSubview(self.bigImgView)
        self.bigImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self.smallImgView.snp.top).offset(-5)
        }
        self.bigImgView.addSubview(self.nameLable)
        self.nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.bigImgView).offset(5)
            make.bottom.equalTo(self.bigImgView).offset(-5)
        }
        self.bigImgView.addSubview(self.numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.bigImgView)
            make.centerY.equalTo(self.nameLable)
        }
        self.bigImgView.addSubview(self.personImgView)
        self.personImgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.numberLabel.snp.left)
            make.centerY.equalTo(self.numberLabel)
        }
    }
}
