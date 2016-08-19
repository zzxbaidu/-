//
//  LLDeatilItemController.swift
//  单糖
//
//  Created by JYD on 16/8/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SVProgressHUD
class LLDeatilItemController: LLBaseController {

    /// 模型数组
    var model:LLItemModel?
    /// /**大的 scrView 的Y 方向偏移量 */
    var offSet:CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: #selector(LLDeatilItemController.rigthItemClick))
        
        automaticallyAdjustsScrollViewInsets = false

      
        guard  let imageArr = model?.image_urls else {
        SVProgressHUD.showErrorWithStatus("暂无图片")
            
            return
        }
       shuffleImageArr = NSMutableArray(array: imageArr)
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 添加子视图
    private func setupUI() {
    
        view.addSubview(bgScrollView)
        
        bgScrollView.addSubview(headView)
        bgScrollView.contentSize = CGSizeMake(0, 2 * SCREEN_HEIGHT)
        
        bgScrollView.addSubview(titleView)
        
        titleView.frame = CGRect(x: 0, y: 363, width: SCREEN_WITH, height: 44)
        titleView.addSubview(indicatorView)
        titleView.backgroundColor = UIColor.whiteColor()
        bgScrollView.addSubview(contentScrollView)
        
        contentScrollView.frame = CGRect(x: 0, y: 407, width: SCREEN_WITH, height: SCREEN_HEIGHT)
        
        contentScrollView.addSubview(photoShowView)
        
        
        contentScrollView.contentSize = CGSizeMake(2 * SCREEN_WITH, 0)
        
        contentScrollView.addSubview(commentView)
        
        
        //添加两个标题
        for index in 0..<titleArr.count {
            
            let btn = UIButton(type: .Custom)
            
            titleView.addSubview(btn)
            
            let btnW = SCREEN_WITH / 2
            
            let btnH = titleView.height
            
            let btnY = CGFloat (0)
            
            let btnX = CGFloat (index) * btnW
            
             buttonArr.addObject(btn)
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            
            btn.setTitle(titleArr[index] as? String, forState: .Normal)
            
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.tag = index
            
            btn.addTarget(self, action: #selector(titleButtonClick(_:)), forControlEvents: .TouchUpInside)
            
            //指示器
            
            if index == 0 {
                
                btn.setTitleColor(UIColor.redColor(), forState: .Normal)
                
                indicatorView.frame = CGRect(x: btn.x, y: btn.y + btn.height - 2, width: btn.width, height: 2)
            }
            
            
            
        }
        
       setupHeadViewUI()
    }
          // MARK: ---- 添加头部的 UI
    private func setupHeadViewUI() {
        let  cycleView = SDCycleScrollView(frame: CGRect(x: 0,y: 0,width: SCREEN_WITH,height: 220), delegate: nil, placeholderImage: UIImage(named: "Me_ProfileBackground"))
        cycleView.imageURLStringsGroup = self.shuffleImageArr as [AnyObject]
        headView.addSubview(cycleView)
        
        let titleLable = UILabel()
        headView.addSubview(titleLable)
        titleLable.text = model?.name
        titleLable.textColor = UIColor.darkGrayColor()
        titleLable.font = UIFont.systemFontOfSize(16)
        titleLable.numberOfLines = 0
        titleLable.snp_makeConstraints { (make) in
            make.top.equalTo(cycleView.snp_bottom).offset(5)
            make.left.equalTo(self.headView).offset(12)
        }
        
        let priceLable = UILabel()
        headView.addSubview(priceLable)
        priceLable.text = "¥ " + (model?.price)!
        priceLable.textColor = UIColor.redColor()
        priceLable.font = UIFont.systemFontOfSize(18)
        
        priceLable.snp_makeConstraints { (make) in
            make.left.equalTo(titleLable.snp_left)
            make.top.equalTo(titleLable.snp_bottom).offset(5)
        }
        
        let descriptioLable = UILabel()
        headView.addSubview(descriptioLable)
        descriptioLable.text = model?.descriptio
        descriptioLable.textColor = UIColor.darkGrayColor()
        descriptioLable.font = UIFont.systemFontOfSize(14)
        descriptioLable.numberOfLines = 0
        descriptioLable.snp_makeConstraints { (make) in
            make.top.equalTo(priceLable.snp_bottom).offset(5)
            make.left.equalTo(titleLable.snp_left)
            make.right.equalTo(self.headView).offset(-12)
            make.bottom.equalTo(self.headView.snp_bottom).offset(-5)
        }

       
        view.addSubview(bottomView)
        
        bottomView.bringSubviewToFront(view)
        
        bottomView.snp_makeConstraints { (make) in
            make.right.left.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(45)
        }
        
        
    }
    
          // MARK: ---- 按钮的点击方法
    
    @objc private func rigthItemClick() {
    
        
      let   actionSheet = UIActionSheet(title: "分享到",
                                    delegate: nil, cancelButtonTitle: "取消",
                                    destructiveButtonTitle: nil,
                                    otherButtonTitles: "微信好友", "微信朋友圈", "新浪微博", "QQ空间")
        
       
        
        actionSheet.showInView(self.view)
    }
    
    @objc private func titleButtonClick(btn:UIButton) {
        
        let offSetX = CGFloat (btn.tag) * contentScrollView.width
        
        let offSetY = contentScrollView.contentOffset.y
        
        let offSet = CGPoint(x: offSetX, y: offSetY)
        
        //指示器跟随滚动
        
        UIView.animateWithDuration(0.25) { 
            self.indicatorView.center = CGPoint(x: btn.center.x, y: self.indicatorView.center.y)
        }
        
        contentScrollView.setContentOffset(offSet, animated: true)
        
       
    }
    
    deinit {
        
        print("控制器试了")
        
       
        
    }
    
    

    
    

         // MARK: ---- 懒加载控件
    
    /// 大的背景
    private lazy var bgScrollView:UIScrollView = {
        
        let scr = UIScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WITH, height: SCREEN_HEIGHT))
        scr.backgroundColor = UIColor.darkGrayColor()
        scr.bounces = false
        scr.delegate = self
        return scr
    
    
    }()
    
    /// 标题视图
    private lazy var titleView:UIView = UIView()
    
    /// 头部视图
    private lazy var headView:UIView = {
    let titleV = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 360))
        
        titleV.backgroundColor = UIColor.whiteColor()
        return titleV
    
    }()
    
    /// 中部容器视图
    private lazy var contentScrollView:UIScrollView =  {
        
        let content = UIScrollView()
        content.bounces = false
        content.pagingEnabled = true
        content.showsVerticalScrollIndicator = false
        content.delegate = self
        
        return content
    
    }()
    
    /// 图文介绍
    private lazy var photoShowView:LLPhotoShowView = {
    
        let photoView = LLPhotoShowView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 45), urlStr: (self.model?.url)!)
    
      photoView.webView.scrollView.delegate = self
        return photoView
    
    }()
    
    /// 评论
    private lazy var commentView:LLCommentsView = {
        
        let commetView = LLCommentsView(frame:  CGRect(x: SCREEN_WITH, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT))
        
        commetView.scroll.delegate = self
        
        return commetView
        
    }()
    
    /// 指示器
    private lazy var indicatorView:UIView = {
        
        let v = UIView()
        
    
        
        v.backgroundColor = UIColor.redColor()
        
        return v
    
    }()
    
    
    private lazy var titleArr:NSArray = ["图文介绍","评论(0)"]

    /// 盛放按钮控件的数组
    private lazy var buttonArr:NSMutableArray = NSMutableArray(capacity: 1)
    
    /// 轮播图数组
    private lazy var shuffleImageArr:NSMutableArray = NSMutableArray(capacity: 1)
    
    /// 底部视图
    private lazy var bottomView:LLItemDetailBottomView = {
        
        
        
        let bottomView = LLItemDetailBottomView(frame: CGRectZero, buttonBlock: { (button) in
            
            let detaVc = LLDetailsController()
            detaVc.source = 2
            detaVc.detailUrl = self.model?.purchase_url
            
            self.presentViewController(detaVc, animated: true, completion: nil)
        })
        
        return bottomView
    
    
    }()
}

// MARK: - UIScrollViewDelegate UITableViewDelegate
extension LLDeatilItemController:UIScrollViewDelegate,UITableViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //判断是否是子视图滚动
        let isContent = (scrollView == photoShowView.webView.scrollView || scrollView == commentView.scroll)
        
        
        if isContent {
            
            let  isScroll  = bgScrollView.contentOffset.y < titleView.y
            
            let offSetY = scrollView.contentOffset.y + bgScrollView.contentOffset.y
            
            if isScroll {
                bgScrollView.contentOffset = CGPoint(x: 0, y: offSetY)
            
                scrollView.contentOffset = CGPointZero

            } else if scrollView.contentOffset.y <= 0 && !isScroll {
                
                if bgScrollView.contentOffset.y >= titleView.y {
                    bgScrollView.contentOffset = CGPoint(x: 0, y: offSetY)
                }
            
            }
        }else if scrollView == bgScrollView {
        
        
            if bgScrollView.contentOffset.y >= titleView.y {
                
                bgScrollView.contentOffset = CGPoint(x: 0, y: titleView.y)
            }
            
            offSet = scrollView.contentOffset.y
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //判断是否是子视图滚动
        let isContent = (scrollView == photoShowView.webView.scrollView ||  scrollView ==  commentView.scroll)

        if isContent {
            
            let offSetY = bgScrollView.contentOffset.y
            
            if offSetY < 0 {
                
                UIView.animateWithDuration(0.25, animations: { 
                    dispatch_after( dispatch_time_t (0.35), dispatch_get_main_queue(), {
                        self.bgScrollView.setContentOffset(CGPointZero, animated: true)
                    })
                })
            }
        }
        
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == contentScrollView {
            
            for index in 0..<buttonArr.count {
                
                let btn = buttonArr[index] as?UIButton
                
                btn?.setTitleColor(UIColor.blackColor(), forState: .Normal)
                
            }
            
            let index = scrollView.contentOffset.x / contentScrollView.width
            
            let button = buttonArr[Int(index)] as?UIButton
            
            button?.setTitleColor(UIColor.redColor(), forState: .Normal)
            
            UIView.animateWithDuration(0.25, animations: { 
                
                self.indicatorView.center = CGPoint(x: (button?.center.x)!, y: self.indicatorView.center.y)
            })
            
            
        }
    }
    
   


}


