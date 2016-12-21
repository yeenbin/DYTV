//
//  RecommendViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/8.
//  Copyright © 2016年 yoke. All rights reserved.
//  推荐控制器

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50 //头部视图的高度
private let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalH = kItemWidth * 3 / 4
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {
    
    lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //创建 UIcollection
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        //注册头部视图的nib文件
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
//    fileprivate lazy var topHeaderView : CollectionHeaderView = {
//        let headerView = CollectionHeaderView.collectionHeaderView()
//        headerView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kHeaderViewH)
//        headerView.titleLabel.text = "常见"
//        headerView.iconImageView.image =  UIImage(named: "Img_orange")
//        return headerView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = UIColor().randomColor()
       //MARK: - 懒加载属性
        
        
        //设置UI界面
        setupUI()
    }
    
}

//MARK: - UI界面设置的方法
extension RecommendViewController {
    
    
    fileprivate func  setupUI() {
       
        view.addSubview(collectionView)

    }
}

//MARK: - 遵循UICollectionViewDataSource的方法
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section == 0 ? 8 : 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
//        headerView.titleLabel.text = "全部"
//        headerView.iconImageView.image = UIImage(named: "Img_orange")
//        headerView.isHidden = true
        
        return headerView
    }
}
