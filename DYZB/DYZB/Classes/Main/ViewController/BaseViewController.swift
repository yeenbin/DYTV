//
//  BaseViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/28.
//  Copyright © 2016年 yoke. All rights reserved.
//  基础控制器 主要实现加载的动画

import UIKit

class BaseViewController: UIViewController {

    //MARK: - 定义属性
    var contentView : UIView?
    //MARK: - 懒加载属性  加载动画
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    //MARK: - 系统的回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


extension BaseViewController {
    
    //初始化视图的方法
    func setupUI() {
        //1.隐藏内容的View
        contentView?.isHidden = true
        
        //2.添加动画的视图
        view.addSubview(animImageView)
        
        //3.开始执行动画
        animImageView.stopAnimating()
        animImageView.startAnimating()
        
        //4.设置View的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        
    }
    
    //数据加载完毕 关闭动画
    func loadDataFinished() {
        //停止动画
        animImageView.stopAnimating()
        
        animImageView.isHidden = true
        
        contentView?.isHidden = false
        
        
    }
}
