//
//  RecommendGameView.swift
//  DYZB
//
//  Created by yoke on 2016/12/27.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kedgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - 定义属性
    var groups : [BaseGameModel]?{
        didSet{
            //刷新表格
            collectionView.reloadData()
        }
    }
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父视图的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kedgeInsetMargin, bottom: 0, right: kedgeInsetMargin)
    
        
    }
    
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 90)
    }
    
}

//MARK: - 提供一个快捷创建RecommendGameView的方法
extension RecommendGameView {
    class func recommendGameView() ->RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil
            , options: nil)?.first as! RecommendGameView
    }
}


//MARK: - 遵循UICollectionViewDataSource的方法
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.game = groups![indexPath.item]
        return cell
    }
}
