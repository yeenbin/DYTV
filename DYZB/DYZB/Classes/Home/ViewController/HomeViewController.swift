//
//  HomeViewController.swift
//  DYZB
//
//  Created by yoke on 2016/11/30.
//  Copyright © 2016年 yoke. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK - 设置到导航栏内容
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
