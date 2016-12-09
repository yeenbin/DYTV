//
//  PageTitleView.swift
//  DYZB
//
//  Created by yoke on 2016/12/2.
//  Copyright © 2016 yoke. All rights reserved.
//

import UIKit

//MARK: - 定义协议
protocol PageTitleViewDelegate : class {
    
    func pageTitleView(_ titleView : PageTitleView , selectedIndex index : Int)
}
//MARK: - 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85 ,85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)



class PageTitleView: UIView {

    //MARK: - 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    fileprivate var isScrollEnable : Bool
    
    //定义代理属性
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    //显示文本排列的滚动视图
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false;
        scrollView.bounces = false;
        return scrollView
    }()
    
    fileprivate lazy var  scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 构造函数
    init(frame: CGRect, isScrollEnable : Bool, titles : [String]) {
        
        self.isScrollEnable = isScrollEnable
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension PageTitleView {
    fileprivate func setupUI(){
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的Label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
    }
    
    fileprivate func setupTitleLabels(){
        //0.确定label的一些frame的值
        let  labelW : CGFloat = frame.width / CGFloat(titles.count)
        let  labelH : CGFloat = frame.height - kScrollLineH
        let  labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label中添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollViewLine的属性
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //2.1 设置scrollLine的属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
        
    }
}

//MARK:-  监听Label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        //0.获取当前的label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //1.如果重复点击同一个label 那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.对调新旧label的文字颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条的位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        //6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(_ progress:CGFloat, sourceIndex : Int , targetIndex : Int){
        //0.取出sourceLabel 和 targetLabel
        let sourceLable = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //1.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLable.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLable.frame.origin.x + moveX
        
        //2.0 取出颜色变化的范围
        let colorData = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1 , kSelectColor.2 - kNormalColor.2)
        
        sourceLable.textColor = UIColor(r: kSelectColor.0 - colorData.0 * progress, g: kSelectColor.1 - colorData.1 * progress, b: kSelectColor.2 - colorData.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorData.0 * progress, g: kNormalColor.1 + colorData.1 * progress, b: kNormalColor.2 + colorData.2 * progress)
        
        //3.记录最新的index
        currentIndex = targetIndex
    }
}

