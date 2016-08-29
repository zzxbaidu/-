//
//  LLADViewController.swift
//  仿好书 app
//
//  Created by JYD on 16/7/8.
//  Copyright © 2016年 JYD. All rights reserved.
//

import UIKit

class LLNewFeaturesController: LLBaseController ,UIScrollViewDelegate{
    
    /// 存放本地轮播的四张图片
    private lazy var imgArr = NSMutableArray()
    /// UIScrollView
    var scrollView:UIScrollView?
    /// 分页指示器
    var pageControl:UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        
        //循环添加四张图片 //walkthrough_1
        for i in 0..<4 {
            imgArr.addObject("\("walkthrough_")\(i+1).png")
        }
        
        self.setupUI()
        
    
        prepareLastImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI()  {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT))
        self.view.addSubview(scrollView!)
        scrollView?.delegate = self
        let count = CGFloat(self.imgArr.count)
        scrollView?.bounces = false
        scrollView?.pagingEnabled = true
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.contentSize = CGSizeMake(SCREEN_WITH * count, 0)
        
        for i in 0..<4 {
            
            let imgView = UIImageView(frame: CGRect(x:CGFloat (i) * (SCREEN_WITH), y: 0, width: (scrollView?.frame.size.width)!, height: SCREEN_HEIGHT))
            scrollView?.addSubview(imgView)
            imgView.image = UIImage(named: imgArr[i] as! String)
            
            
        }
        
        pageControl = UIPageControl(frame: CGRect(x: self.view.centerX - 50, y: self.view.frame.height - 80, width: 100, height: 100))
        self.view .addSubview(pageControl!)
        pageControl?.numberOfPages = 4;
        pageControl?.currentPage = 0;
        
        pageControl?.pageIndicatorTintColor = UIColor.darkGrayColor()
        
        pageControl?.currentPageIndicatorTintColor = LLColor
        // 提示：需要禁止用户交互，否则用户点击小圆点，会移动，但是页面不会变化
        pageControl?.userInteractionEnabled = false
    }
    /**
     添加立即浏览按钮
     */
    func prepareLastImage() {
        
        let  imgageView = self.scrollView?.subviews.last as!UIImageView
        //imgageView默认不予用户交互
        imgageView.userInteractionEnabled = true
        
        experienceBtn.frame =  CGRect(x: self.view.centerX - 50 , y: self.view.frame.height - 140, width: 120, height: 45)
        
     
        experienceBtn.setTitle("立即体验", forState: . Normal)
        experienceBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        experienceBtn.titleLabel?.font = UIFont.systemFontOfSize(18)
        experienceBtn.backgroundColor = UIColor.whiteColor()
        imgageView.addSubview(experienceBtn)
        experienceBtn.layer.masksToBounds = true
        experienceBtn.layer.cornerRadius = 7.0
        experienceBtn.alpha = 0.8
        experienceBtn.userInteractionEnabled = true
        experienceBtn.addTarget(self, action: #selector(self.onceExperience), forControlEvents: .TouchUpInside)
        
        
        
    }
    
    
    private lazy var experienceBtn:UIButton = UIButton(type: UIButtonType.Custom)
    
    /**
     立即体验的按钮
     */
    func onceExperience() {
        
        self.presentViewController(LLTabBarController(), animated: true, completion: nil)
        
        
        
    }
    
    
}
// MARK: - UICollectionView数据源方法和代理方法
extension LLNewFeaturesController {
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        
        self.pageControl?.currentPage = NSInteger (scrollView.contentOffset.x / scrollView.bounds.size.width)
        
        
        let index = scrollView.contentOffset.x / scrollView.width
        
        print(Int (index))
        
        if Int (index) == 3 {
            
        //prepareLastImage()
            
            //添加动画
            let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            shakeAnimation.duration = 0.25
            shakeAnimation.fromValue = -20
            shakeAnimation.toValue = 20
            shakeAnimation.autoreverses = true
            experienceBtn.layer.addAnimation(shakeAnimation, forKey: nil)

            
        }
        
    }
    
}

