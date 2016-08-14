//
//  LLHomeController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDCycleScrollView
import SDWebImage

class LLHomeController: LLBaseController {
/// 设置可视的标题为3个
    let visualCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        getCarouselImage()
        
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      // MARK: ---- 添加 UI
    
    private func setupUI() {
        
        view.addSubview(titleScroll)
        view.addSubview(contentScroll)

        //循环添加子控制器
        
        for index in 0..<titleArr.count {
            
            let childVc = LLChildrenController()
            
            let title = titleArr[index] as? LLTitleModel
            childVc.title = title?.name
            addChildViewController(childVc)
            
            
        }
        
        //设置标题的 title
        
        for index in 0..<titleArr.count {
            
            let lableW = SCREEN_WITH / CGFloat (visualCount)
            let lableH = CGFloat (44.0)
            let lableY =  0
            let lableX = CGFloat (index) * lableW
            
            let titleLable = UILabel(frame: CGRect(x: lableX, y: CGFloat (lableY), width: lableW, height: lableH))
            titleLable.tag = index
            titleLable.text = childViewControllers[index].title
            titleScroll.addSubview(titleLable)
            tempTitleArr.addObject(titleLable)
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
        guard let fristChildVc = childViewControllers.first as?UITableViewController  else{
        return
        }
        
        fristChildVc.view.frame = contentScroll.bounds
       
        contentScroll.addSubview(fristChildVc.view)
        
        
        let imageArr = NSMutableArray(capacity: 1)
        
        for index in 0..<carouseArr.count {
            
            let model = carouseArr[index] as? LLCarouselModel
            imageArr.addObject((model?.image_url)!)
        }
        
        let  cycleView = SDCycleScrollView(frame: CGRect(x: 0,y: 0,width: SCREEN_WITH,height: 150), delegate: self, placeholderImage: UIImage(named: "Me_ProfileBackground"))
        
        cycleView.imageURLStringsGroup = imageArr as [AnyObject]
        fristChildVc.tableView.tableHeaderView = cycleView

        
        //添加指示器 取出第一个 UILable
        
         let fristLable = tempTitleArr[0] as!UILabel
        indicatorView.frame = CGRect(x: fristLable.x, y: fristLable.y + fristLable.height - 2, width: fristLable.width, height: 2)
        titleScroll.addSubview(indicatorView)
        
   
    
    }
    
     // MARK: ---- 添加轮播图的UI
    private func setCarouselUI() {
        
        
    
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
            
            self.setupUI()

            
        
        }
    
    }
     // MARK: ---- 获取轮播图数据
    
    private func getCarouselImage() {
        
     
    
        let urlString = baseUrl + "v1/banners?channel=iOS"
        
        LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
            
            let dateDict = backDate as?NSDictionary
            
            let arrDict = dateDict?.objectForKey("data") as?NSDictionary
            
            guard let arr = arrDict?.objectForKey("banners") as? NSArray else {
               SVProgressHUD.showErrorWithStatus("加载轮播图失败")
                return
            
            }
            //字典转模型
            for index in 0..<arr.count{
                let tempArr = arr[index]
                let model = LLCarouselModel(dict: tempArr as! [String : AnyObject])
               self.carouseArr.addObject(model)
            
            
            }
            
            self.getHomeTitleDate()
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
        
        let titleScr = UIScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WITH, height: 44))
        
        titleScr.showsVerticalScrollIndicator = false
        titleScr.showsHorizontalScrollIndicator = false
        
        return titleScr
    
    }()
     ///容器视图
    private lazy var contentScroll:UIScrollView = {
        
        let contentScr = UIScrollView(frame: CGRect(x: 0, y: 108, width: SCREEN_WITH, height: SCREEN_HEIGHT - 108))
        contentScr.delegate = self
        contentScr.backgroundColor = UIColor.clearColor()
        contentScr.pagingEnabled = false
        contentScr.decelerationRate = 0.1
        contentScr.bounces = false
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
    
    //头部盛装UILable的数组
    
    private lazy var tempTitleArr:NSMutableArray = NSMutableArray(capacity: 1)
    /// 轮播模型数组
    private lazy var carouseArr:NSMutableArray = NSMutableArray(capacity: 1)


}
// MARK: - UIScrollViewDelegate
extension LLHomeController :UIScrollViewDelegate{
    
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        for view in tempTitleArr {
            
            let tempView = view as!UILabel
             tempView.textColor = UIColor.blackColor()
            
        }
        
        let index = scrollView.contentOffset.x / scrollView.width
        
        
        let lable = titleScroll.subviews[Int(index)] as!UILabel
        
         lable.textColor = UIColor.redColor()
        
        
        UIView.animateWithDuration(0.25) {
            
            if (lable.center.x > self.titleScroll.width / 2 &&  (self.titleScroll.contentSize.width - lable.center.x) > self.titleScroll.width / 2 ) {
                
                self.titleScroll.contentOffset = CGPoint(x: lable.center.x - self.titleScroll.width / 2, y: self.titleScroll.contentOffset.y)
            
        }
        
        if lable.center.x <= self.titleScroll.width / 2 {
            self.titleScroll.contentOffset = CGPoint(x: 0, y: self.titleScroll.contentOffset.y)
        }
        
        if self.titleScroll.contentSize.width - lable.center.x <= self.titleScroll.width / 2 {
            
            self.titleScroll.contentOffset = CGPoint(x: self.titleScroll.contentSize.width - self.titleScroll.width , y: self.titleScroll.contentOffset.y)
        }
        
        //指示器跟随滚动
        
        UIView.animateWithDuration(0.0, animations: {
           self.indicatorView.center = CGPoint(x: lable.center.x, y: self.indicatorView.center.y)
        })
        
        
    }
        
   
        
        let Vc = childViewControllers[Int(index)]
        
         contentScroll.addSubview(Vc.view)
        
         Vc.view.frame = scrollView.bounds
        
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        
        if !decelerate {
            
            scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        }
    }

}

// MARK: - SDCycleScrollViewDelegate
extension LLHomeController :SDCycleScrollViewDelegate{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        
    }

}
