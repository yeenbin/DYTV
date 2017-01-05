//
//  AmuseViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/8.
//  Copyright © 2016年 yoke. All rights reserved.
//  娱乐控制器

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseView : AmuseMenuView = {
        let amuseView = AmuseMenuView.amuseMenuView()
        amuseView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        amuseView.backgroundColor = UIColor.orange
        return amuseView
    }()
    
    fileprivate lazy var testView : UIView = {
       let view = UIView(frame: CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH))
        view.backgroundColor = UIColor.blue
        return view
    }()
}

//MARK: - 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        //添加头部视图到collectionView上
        collectionView.addSubview(amuseView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension AmuseViewController {
    override func loadData() {
        //1.给父类中的baseVM进行赋值
        baseVM = amuseVM
        
        //2.请求数据
        amuseVM.loadAmuseData {
            
            print(self.amuseVM.anchorGroups.count,self.baseVM.anchorGroups.count)
            //1.刷新表格
            self.collectionView.reloadData()
            
            //2.调整数据
            var temGroup = self.amuseVM.anchorGroups
            temGroup.removeFirst()
            self.amuseView.groups = temGroup
            
            //3.加载数据完毕
            self.loadDataFinished()
        }
    }
}
