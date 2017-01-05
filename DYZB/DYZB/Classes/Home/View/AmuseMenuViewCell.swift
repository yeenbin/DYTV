//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by yoke on 2016/12/30.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

private let kGameCell = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {

    //MARK: - 定义模型属性
    var groups : [AnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - 从xib加载文件
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册表视图的单元格
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
    }
    
    //重新设置item的尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension AmuseMenuViewCell :UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! CollectionGameCell
        cell.game = groups![indexPath.row]
        return cell
    }
    
}
