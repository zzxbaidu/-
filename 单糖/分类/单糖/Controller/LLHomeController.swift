//
//  LLHomeController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD

class LLHomeController: LLBaseController {
/// 设置可视的标题为5个
    let visualCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        getHomeTitleDate()
        
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      // MARK: ---- 添加 UI
    
    private func setupUI() {
        
        view.addSubview(titleScroll)
        titleScroll.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(64)
            make.height.equalTo(44)
        }
        
        view.addSubview(contentScroll)
        contentScroll.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(titleScroll.snp_bottom)
            make.bottom.equalTo(view)
        }
        
        //循环添加子控制器
        
        for index in 0..<titleArr.count {
            
            let childVc = LLChildrenController()
            childVc.title = titleArr[index] as? String
            addChildViewController(childVc)
            
            
        }
        
        //设置标题的 title
        
        for index in 0..<titleArr.count {
            
            let lableW = SCREEN_WITH / CGFloat (visualCount)
            let lableH = titleScroll.height
            let lableY =  0
            let lableX = CGFloat (index) * lableW
            
            let titleLable = UILabel(frame: CGRect(x: lableX, y: CGFloat (lableY), width: lableW, height: lableH))
            titleLable.tag = index
            titleScroll.addSubview(titleLable)
            titleLable.textAlignment = .Center
            titleLable.font = UIFont.systemFontOfSize(16)
            
            titleLable.userInteractionEnabled = true
            
            titleLable.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleLableClick(_:))))
            
            if index == 0 {
                
                titleLable.textColor = UIColor.redColor()
            }
            
            
        }
        
        //设置contentScroll的偏移量
        
        let offSetX = CGFloat(childViewControllers.count) * SCREEN_WITH
        contentScroll.contentSize = CGSizeMake(offSetX, 0)
        
        //设置 的偏移量
        
        titleScroll.contentSize = CGSizeMake(SCREEN_WITH / CGFloat (visualCount) *  CGFloat(titleArr.count), 0)
        
        //设置默认控制器
        guard let fristChildVc = childViewControllers.first  else{
        return
        }
        
        fristChildVc.view.frame = contentScroll.bounds
        fristChildVc.view.backgroundColor = UIColor.whiteColor()
        contentScroll.addSubview(fristChildVc.view)
        
        
        //添加指示器 取出第一个 UILable
        
         let fristLable = titleScroll.subviews[0]
        indicatorView.frame = CGRect(x: fristLable.x, y: fristLable.y + fristLable.height - 2, width: fristLable.width, height: 2)
        titleScroll.addSubview(indicatorView)
        
   
    
    }
    
          // MARK: ----  获取Title数据
    
    private func getHomeTitleDate() {
        
        let urlStr =   baseUrl + "v2/channels/preset?gender=1&generation=1"
        LLNetWorkTools.sharedTools.loadGETDate(urlStr, param: "") { (backDate) in
            
            let resultDict = backDate as!NSDictionary
            
            guard let resultDate = resultDict.objectForKey("data")as?NSDictionary  else {
             SVProgressHUD.showErrorWithStatus("加载失败,请重试")
            return
            }
            
            guard let channelsDict = resultDate.objectForKey("channels") as? NSArray else {
                
                return
            }
            
          //转模型
           
            
            for index in 0..<channelsDict.count  {
                
                let model = LLTitleModel(dict: channelsDict[index] as! [String : AnyObject])
                
                 self.titleArr.addObject(model)

            
            }
            
            
            for model in 0..<self.titleArr.count {
                
                
          let m = self.titleArr[model] as!LLTitleModel
            print( m.name)
                
            
            }

            
        
        }
    
    }
    
          // MARK: ---- 切换按钮的点击方法
    
    @objc private func titleLableClick(recognizer:UIGestureRecognizer) {
    
    let titleLable = recognizer.view as! UILabel
        
        let offSetX = CGFloat (titleLable.tag) * contentScroll.width
        let offSetY = contentScroll.contentOffset.y
        
        let offSet = CGPoint(x: offSetX, y: offSetY)
        
        contentScroll.setContentOffset(offSet, animated: true)
        
    }
   
          // MARK: ---- 懒加载
    /// 标题视图

    private lazy var titleScroll:UIScrollView = {
        
        let titleScr = UIScrollView()
        
        titleScr.showsVerticalScrollIndicator = false
        titleScr.showsHorizontalScrollIndicator = false
        
        titleScr.backgroundColor = UIColor.orangeColor()
        return titleScr
    
    }()
     ///容器视图
    private lazy var contentScroll:UIScrollView = {
        
        let contentScr = UIScrollView()
        
        contentScr.backgroundColor = UIColor.redColor()
        contentScr.showsVerticalScrollIndicator = false
        contentScr.delegate = self
        
        return contentScr
        
    }()
    
    //标题数组
    private lazy var titleArr:NSMutableArray = NSMutableArray(capacity: 1)
    ///容器视图
    private lazy var indicatorView:UIView = {
        
        let v = UIView()
        
        v.backgroundColor = UIColor.redColor()
        return v
        
    }()
    
    //头部标题模型数组
    
    
    
    


}
// MARK: - UIScrollViewDelegate
extension LLHomeController :UIScrollViewDelegate{
    
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        for view in contentScroll.subviews {
            
            if view.isMemberOfClass(UILabel.self) {
                
                let lable = view as! UILabel
                
                lable.textColor = UIColor.blackColor()
            }
            
        }
        
        let index = scrollView.contentOffset.x / contentScroll.width
        
        let lable = titleScroll.subviews[Int(index)] as!UILabel
        
        lable.textColor = UIColor.redColor()
        
        
       UIView.animateWithDuration(0.3) {
            
            if (lable.center.x > self.titleScroll.width / 2 &&  (self.titleScroll.contentSize.width - lable.center.x) > self.titleScroll.width / 2 ) == true{
                
                self.titleScroll.contentOffset = CGPoint(x: lable.center.x - self.titleScroll.width / 2, y: self.titleScroll.contentOffset.y)
            
        }
        
        if lable.center.x <= self.titleScroll.width / 2 {
            self.titleScroll.contentOffset = CGPoint(x: 0, y: self.titleScroll.contentOffset.y)
        }
        
        if self.titleScroll.contentSize.width - lable.center.x <= self.titleScroll.width / 2 {
            
            self.titleScroll.contentOffset = CGPoint(x: self.titleScroll.width, y: self.titleScroll.contentOffset.y)
        }
        
        //指示器跟随滚动
        
        UIView.animateWithDuration(0.5, animations: { 
           self.indicatorView.center = CGPoint(x: lable.center.x, y: self.indicatorView.center.y)
        })
        
        
    }
        
         let Vc = childViewControllers[Int(index)]
        
        contentScroll.addSubview(Vc.view)
        
        Vc.view.frame = contentScroll.bounds
        
        
        
    }

}
