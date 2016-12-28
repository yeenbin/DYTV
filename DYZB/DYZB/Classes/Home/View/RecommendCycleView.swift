//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by yoke on 2016/12/26.
//  Copyright © 2016年 yoke. All rights reserved.
//  无线循环滚动视图

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    //MARK: - 定义属性
    var cycleTimer : Timer? //定时器
    
    //数据源-模型数组
    var cycleModels : [CycleModel]? {
        didSet{
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间的某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cycleCell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //布局的尺寸必须是在layoutSubview中 否则拿到的尺寸会不正确
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
    }
    
}

//MARK: - 遵循UICollectionViewDataSource的方法 
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        return cell
    }
}

//MARK: - 遵循UICollectionViewDelegate的方法
extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = collectionView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //滑动过程中计算pageControl 显示的页数
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    //开始滚动的时候取消计时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    //结束滚动的时候启动计时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK: - 提供一个快速创建view的方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK: - 对定时器的操作方法
extension RecommendCycleView {
    fileprivate func addCycleTimer(){
       cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    //停止计时器
    fileprivate func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    //滚动到下一个
    @objc fileprivate func scrollToNext(){
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
