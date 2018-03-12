//
//  YJQHeaderCollectionReusableView.swift
//  DYZB
//
//  Created by yjq on 2018/3/9.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit
import SnapKit

class YJQHeaderCollectionReusableView: UICollectionReusableView {
    // MARK: - 懒加载属性
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    private lazy var icon: UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"home_header_hot"))
        imgView.contentMode = .center
        return imgView
    }()
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "标题"
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    private lazy var moreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("更多 >", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
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
        self.backgroundColor = .white
        self.addSubview(grayView)
        grayView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(10)
        }
        self.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(5)
            make.left.equalTo(self).offset(8)
        }
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon)
            make.left.equalTo(icon.snp.right).offset(8)
        }
        self.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipLabel)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(self.snp.height).offset(-10)
            make.width.equalTo(60)
        }
    }
}
