//
//  GameViewController.swift
//  DYZB
//
//  Created by yoke on 2016/12/8.
//  Copyright © 2016 yoke. All rights reserved.
//  游戏控制器

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH = kItemW * 6 / 5

private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"



class GameViewController: BaseViewController {

    //MARK: - 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2.创建uicollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        return collectionView
    }()
    
    //懒加载头部的视图
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kGameViewH + kHeaderViewH), width: kScreenW, height: kHeaderViewH)
        headerView.titleLabel.text = "常见"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    //MARK: - 系统的回调
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        //设置UI
        setupUI()
        
        //请求数据
        loadData()
    }
    

}

//MARK: - 请求数据
extension GameViewController {
    func loadData() {
        gameVM.loadAllGameData {
            //1.展示全部的数据
            self.collectionView.reloadData()
            
            //2.展示常用的游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
            
            //3.数据请求完成
            self.loadDataFinished()
        }
    }
}
//MARK: - 设置UI的界面
extension GameViewController {
    override func setupUI() {
        //0.给contentView赋值
        contentView = collectionView
        
        //1.添加collectionbview
        view.addSubview(collectionView)
        //2.添加顶部的headerView
        collectionView.addSubview(topHeaderView)
        //3.添加常用的游戏推荐视图
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kHeaderViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}

extension GameViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.game = gameVM.games[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //0.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "全部"
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
