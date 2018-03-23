//
//  YJQBaseViewController.swift
//  DYZB
//
//  Created by yjq on 2018/3/23.
//  Copyright © 2018年 YJQ. All rights reserved.
//

import UIKit

class YJQBaseViewController: UIViewController {
    var contentView: UIView?
    private var imgView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyDataDisplay()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension YJQBaseViewController {
    func emptyDataDisplay() {
        view.backgroundColor = UIColor.purple
        contentView?.isHidden = true
        let imgview = UIImageView(image: #imageLiteral(resourceName: "img_loading_1"))
        self.imgView =  imgview
        self.view.addSubview(imgview)
        imgview.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imgview.center = self.view.center
        imgview.animationImages = [#imageLiteral(resourceName: "img_loading_1"),#imageLiteral(resourceName: "img_loading_2")]
        startImageAnimation()
    }
    
    func startImageAnimation() {
        self.imgView?.animationDuration = 0.5
        self.imgView?.animationRepeatCount = LONG_MAX
        self.imgView?.startAnimating()
    }
    func stopImageAnimation() {
        self.imgView?.stopAnimating()
        self.imgView?.isHidden = true
        contentView?.isHidden = false
    }
}
