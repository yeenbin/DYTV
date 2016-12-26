//
//  HomeViewController.swift
//  DYZB
//
//  Created by yoke on 2016/11/30.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //MARK: - 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, isScrollEnable: true, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContenView : PageContenView = {
        //0.确定内容的frame
        let contenH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contenH)
        
        var childVcs = [UIViewController]()
        
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let contentView = PageContenView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
    
        contentView.delegate = self
        return contentView
    }()
    
    //MARK: -控制器生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.初始化导航栏
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
}

//MARK - 设置到导航栏内容
extension HomeViewController {
    
    fileprivate func setupNavigationBar(){
        //不需要调整
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationLeftBar()
        setupNavigationRightBar()
    
        //添加titleView
        view.addSubview(pageTitleView)
        
        //添加contentView
        view.addSubview(pageContenView)
    }
    
    //创建左边的按钮
    private func setupNavigationLeftBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.leftItemClick), for:.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    //
    private func setupNavigationRightBar(){
        //1.确定UIButton的尺寸
        let size = CGSize(width: 40, height: 44)
        
        //2.创建历史的按钮
        let  historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size, target: self, action: #selector(self.historyItemClick))
        
        //3.创建搜索的按钮
         let  searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size, target: self, action: #selector(self.searchItemClick))
        
        //4.创建二维码的按钮
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, target: self, action: #selector(self.qrCodeItemClick))
        //5.设置导航栏右边的按钮
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
        
    }
    
    //MARK - 导航栏的事件处理
    @objc private func leftItemClick(){
        print("点击了logo")
    }
    
    @objc private func qrCodeItemClick(){
        print("点击了二维码")
    }
    
    @objc private func searchItemClick(){
        print("点击了搜索")
    }
    
    @objc private func historyItemClick(){
        print("点击了历史")
    }
}

//MARK: - 遵循PageTitleViewDelegate的方法实现
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(index)
    }
}

//MARK: - 遵循PageContenViewDelegate的方法实现
extension HomeViewController : pageContenViewDelegate {
    func pageContenView(_ contenView: PageContenView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
//最low的方式创建导航栏的方法
/*
extension HomeViewController {
    
    fileprivate func setupNavigationBar(){
        setupNavigationLeftBar()
        setupNavigationRightBar()
    }
    
    //创建左边的按钮
    private func setupNavigationLeftBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.leftItemClick), for:.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    //
    private func setupNavigationRightBar(){
        //1.确定UIButton的尺寸
        let size = CGSize(width: 40, height: 44)
        
        //2.创建历史的按钮
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named:"image_my_history"), for:.normal)
        historyBtn.setImage(UIImage(named:"image_my_history_click"), for: .highlighted)
        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        historyBtn.addTarget(self, action: #selector(self.historyItemClick), for: .touchUpInside)
        let  historyItem = UIBarButtonItem(customView: historyBtn)
        
        //3.创建搜索的按钮
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        searchBtn.addTarget(self, action: #selector(self.searchItemClick), for: .touchUpInside)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        //4.创建二维码的按钮
        let qrCodeBtn = UIButton()
        qrCodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
        qrCodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
        qrCodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        qrCodeBtn.addTarget(self, action: #selector(self.qrCodeItemClick), for: .touchUpInside)
        let qrCodeItem = UIBarButtonItem(customView: qrCodeBtn)

        //5.设置导航栏右边的按钮
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
        
    }
    
    //MARK - 导航栏的事件处理
    @objc private func leftItemClick(){
        print("点击了logo")
    }
    
    @objc private func qrCodeItemClick(){
        print("点击了二维码")
    }
    
    @objc private func searchItemClick(){
        print("点击了搜索")
    }
    
    @objc private func historyItemClick(){
        print("点击了历史")
    }
}
 
 */
