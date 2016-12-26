//
//  RecommendViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/8.
//  Copyright © 2016年 yoke. All rights reserved.
//  推荐控制器

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3


class RecommendViewController: UIViewController {
    
    //MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //创建 UIcollection
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        ///注册单元格的nib文件
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
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
        
        //加载数据
        loadData()
        
    }
    
}

//MARK: - UI界面设置的方法
extension RecommendViewController {
    
    
    fileprivate func  setupUI() {
       
        view.addSubview(collectionView)

    }
}


extension RecommendViewController{
    func loadData(){
        //1.请求数据
        recommendVM.requestData {
            
            self.collectionView.reloadData()
        }
    }
}

//MARK: - 遵循UICollectionViewDataSource的方法
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.recommendVM.anchorGroups[section].anchors.count

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CollectionBaseCell!
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionBaseCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionBaseCell
        }
        //2.设置数据
        cell.anchor = self.recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
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


extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}






