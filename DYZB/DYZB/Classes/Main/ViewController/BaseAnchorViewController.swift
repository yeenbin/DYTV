//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/29.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3


class BaseAnchorViewController: BaseViewController {
    
    //MARK: - 定义属性
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建collectionView并返回
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    
    //MARK: - 系统的回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData() //加载数据
        
        setupUI()//设置UI
        
    }

}

////MARK: - 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        //1.给父类中的view赋值
        contentView = collectionView
        
        //2.添加collectionView
        view.addSubview(collectionView)
        
        //调用父类的setupUI()方法
        super.setupUI()
    }
}


//MARK: - 加载数据
extension BaseAnchorViewController {
    func loadData(){
        
    }
}


//MARK: - 遵守 UICollectionViewDataSource的数据源
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        //给cell赋值
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出头部视图
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.给头部视图赋值
        headView.group = baseVM.anchorGroups[indexPath.section]
        return headView
    }
}

//MARK: - 遵守 UICollectionViewDelegate的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播的信息
        let anchorModel = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //2.判断是秀场房间 还是普通的房间
        anchorModel.isVertical == 0 ? presentShowRoom() : pushNormalRoom()
    }
    
    //弹出秀场的房间
    private func presentShowRoom(){
        print("跳转到秀场的房间")
    }
    
    //push到普通的房间
    private func pushNormalRoom(){
        print("跳转到普通的房间")
    }
    
}
