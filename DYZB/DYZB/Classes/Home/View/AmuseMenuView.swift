//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by yoke on 2017/1/3.
//  Copyright © 2017年 yoke. All rights reserved.
//

import UIKit
private let kAmuseID = "kAmuseCell"

class AmuseMenuView: UIView {

    //MARK: - 模型属性
    var groups : [AnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    //MARK: - 控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    ////MARK: - 从xib加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseID)
    }
    
    //MARK: - 布局尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//MARK: - 提供一个创建实例的方法
extension AmuseMenuView {
   class func amuseMenuView() -> AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
//MARK: - 遵循UICollectionViewDataSource的协议方法
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {return 0}
        let pageNum = (groups!.count - 1) / 8 + 1
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseID, for: indexPath) as! AmuseMenuViewCell
        //2.给cell赋值
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseMenuViewCell , indexPath : IndexPath){
        //第0页：0~7
        //第1页：8~15
        //1.取出起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2.判断终点位置越界的问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        //3.取出数据并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    //设置pageControl的页数
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.numberOfPages = Int(scrollView.contentOffset.x / collectionView.bounds.width)
    }
}
