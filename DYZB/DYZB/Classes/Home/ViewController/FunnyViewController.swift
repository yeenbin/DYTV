//
//  FunnyViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/8.
//  Copyright © 2016年 yoke. All rights reserved.
//  搞笑控制器

import UIKit
private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //MARK: - 定义属性
    fileprivate lazy var funnyVM : FunnyViewModel =  FunnyViewModel()
    
    
}

//MARK: - 设置界面
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero

        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}
//MARK: - 加载数据
extension FunnyViewController {
    override func loadData() {
        //1.给模型赋值
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            //1.刷新表格
            self.collectionView.reloadData()
            
            //2.数据请求完毕
            self.loadDataFinished()
        }
    }
}
