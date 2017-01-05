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


let kCycleH = kScreenW * 3 / 8
let kGameH : CGFloat = 90


class RecommendViewController: UIViewController {
    
    //MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleH + kGameH), width: kScreenW, height: kCycleH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
       let gameView = RecommendGameView.recommendGameView()
        gameView.backgroundColor = UIColor.red
        gameView.frame = CGRect(x: 0, y: -kGameH, width: kScreenW, height: kGameH)
        return gameView
    }()
    
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
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        ///注册单元格的nib文件
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        //注册头部视图的nib文件
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = UIColor.lightGray
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
        
        //1.将cycleView添加到collectionView上
        collectionView.addSubview(cycleView)
        
        //2.将gameVie添加到collectionView上
        collectionView.addSubview(gameView)
    
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleH + kGameH , left: 0, bottom: 0, right: 0)
    }
}


extension RecommendViewController{
    func loadData(){
        //1.请求数据
        recommendVM.requestData {
            
            self.collectionView.reloadData()
            
            //将数据传递给gameView
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        
        //2.请求无线轮播的数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
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






