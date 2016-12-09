//
//  PageContenView.swift
//  DYZB
//
//  Created by yoke on 2016/12/5.
//  Copyright © 2016 yoke. All rights reserved.
//

import UIKit

protocol pageContenViewDelegate : class {
    
    func pageContenView (_ contenView : PageContenView, progress : CGFloat,sourceIndex : Int , targetIndex : Int)
}

private let ContentCellID = "ContentCellID"


class PageContenView: UIView {

    //MARK: - 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentViewController : UIViewController?
    
    weak var  delegate : pageContenViewDelegate?
    //开始滚动的位置
    fileprivate var startOffsetX : CGFloat = 0;
    
    fileprivate var  isForbidScrollDelegate : Bool = false
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()

    
  //封装构造函数
     init(frame: CGRect , childVcs : [UIViewController], parentViewController : UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension PageContenView {
    fileprivate func setupUI() {
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
            
        }
        
        //添加UIcollectionView 用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - 遵循UIcollectionViewDataSource 
extension PageContenView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.childVcs.count)
        
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.从缓存池中获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2.设置cell的内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK: - 遵循UICollectionViewDelegate
extension PageContenView : UICollectionViewDelegate {
    //滚动视图开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        //记录滚动视图一开始的偏移量
        startOffsetX = scrollView.contentOffset.x
    }
    
    //滚动视图已经滚动了
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果是标题点击事件 就不做操作直接返回
        if isForbidScrollDelegate { return }
        
        //1.定义需要传递出去的数据
        var progress : CGFloat = 0 //滑动的进度
        var sourceIndex : Int = 0 //初始滑动的下标值
        var targetIndex : Int = 0 //目标滑动的下标值
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let collectionViewW = collectionView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            
            progress = currentOffsetX / collectionViewW - floor(currentOffsetX / collectionViewW)
            
            sourceIndex = Int(currentOffsetX / collectionViewW)
            
            targetIndex = sourceIndex + 1
            
            //防止越界问题
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //如果是刚好完全划过
            if currentOffsetX - startOffsetX  ==  collectionViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{//右滑
            progress = 1 - (currentOffsetX / collectionViewW - floor(currentOffsetX / collectionViewW))
            
            targetIndex = Int(currentOffsetX / collectionViewW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3.通知代理
        delegate?.pageContenView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


//MARK: - 对外暴露的方法
extension PageContenView {
    func  setCurrentIndex(_ currentIndex : Int) {
        
        isForbidScrollDelegate = true
        //collectionView 滚动到对应的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
