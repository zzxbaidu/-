//
//  LLMeController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLMeController: LLBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

    self.navigationController?.navigationBar.hidden = true
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 添加子视图
    
    private func setupUI() {
        
     view.addSubview(topHeadView)
        
        topHeadView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(210)
        }
        
        let titleView = UIView()
        view.addSubview(titleView)
        titleView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(topHeadView.snp_bottom)
            make.height.equalTo(44)
        }
        
        //添加上面的线
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor.darkGrayColor()
        
        
        titleView.addSubview(topLineView)
        topLineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleView)
            make.top.equalTo(titleView.snp_top)
            make.height.equalTo(0.3)
        }
        //添加下面的线
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = UIColor.darkGrayColor()
        
        
        titleView.addSubview(bottomLineView)
        bottomLineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleView)
            make.bottom.equalTo(titleView.snp_bottom)
            make.height.equalTo(0.3)
        }
        
        //添加中间的线
        let centerLineView = UIView()
        centerLineView.backgroundColor = UIColor.darkGrayColor()
        
        
        titleView.addSubview(centerLineView)
        centerLineView.snp_makeConstraints { (make) in
            make.center.equalTo(titleView)
            make.width.equalTo(0.8)
            make.height.equalTo(titleView)
        }

        
        //循环添加两个按钮
        
        for index in 0..<titileArr.count {
            
            let btn = UIButton(type: .Custom)
            titleView.addSubview(btn)
            btn.tag = index
            btnArr.addObject(btn)
            let btnW = SCREEN_WITH / CGFloat (2)
            let btnH = CGFloat (42.0)
            let btnY =  CGFloat (0)
            let btnX = CGFloat (index) * btnW
            btn.setTitle(titileArr[index], forState: .Normal)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.addTarget(self, action:  #selector(titleBtnClick(_:)), forControlEvents: .TouchUpInside)
            
            //添加指示器
            if index == 0 {
                //添加指示器 取出第一个 UILable
                
                indicatorView.frame = CGRect(x: btn.x, y: btn.y + btn.height , width: btn.width, height: 2)
                titleView.addSubview(indicatorView)

            }
        }
        
        //添加底部的容器视图
        
        view.addSubview(contentScroll)
        contentScroll.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(titleView.snp_bottom)
        }
        
        //设置contentScroll的偏移量
        
        let offSetX = CGFloat(titileArr.count) * SCREEN_WITH
        contentScroll.contentSize = CGSizeMake(offSetX, 0)

        //循环添加子控制器
        
        for index in 0..<titileArr.count {
            
            let botomView = LLMeBottomView()
        
            contentScroll.addSubview(botomView)
            
            botomView.frame = CGRect(x: CGFloat (index) * SCREEN_WITH, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 210 - 44)
        }
        

  
    }
    // MARK: ---- 切换按钮的点击方法
    
    @objc private func titleBtnClick(btn:UIButton) {
        
      
        let offSetX = CGFloat (btn.tag) * contentScroll.width
        let offSetY = contentScroll.contentOffset.y

        let offSet = CGPoint(x: offSetX, y: offSetY)
        
        contentScroll.setContentOffset(offSet, animated: true)
        
    }

         // MARK: ---- 懒加载
    
    private lazy var topHeadView:LLMeHeadView =  {
        
      weak  var weakSelf = self
        
        let topView = LLMeHeadView(frame: CGRectZero, btnBlock: { (btn) in
            
            if btn.tag == 1 {
            weakSelf!.presentViewController(LLLoginViewController(), animated: true, completion: nil)
            
            
            }else if btn.tag == 2 {
                
                weakSelf!.presentViewController(LLLoginViewController(), animated: true, completion: nil)
            
            }else {
            
            }
        })
        return topView
    }()
    
    private lazy var titileArr = ["喜欢的商品","喜欢的专题"]
    
    private lazy var btnArr = NSMutableArray(capacity: 1)
    
    
    ///容器视图
    private lazy var contentScroll:UIScrollView = {
        
        let contentScr = UIScrollView()
        contentScr.delegate = self
        contentScr.backgroundColor = UIColor.clearColor()
        contentScr.pagingEnabled = true
        contentScr.decelerationRate = 0.0
        contentScr.bounces = false
        contentScr.showsHorizontalScrollIndicator = false
        return contentScr
        
    }()
    
    /// 指示器视图
    private lazy var indicatorView:UIView = {
        
        let v = UIView()
        
        v.backgroundColor = UIColor.redColor()
        return v
        
    }()


}

extension LLMeController:UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        for view in btnArr {
            
            let tempView = view as!UIButton
            tempView.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
        }
        
        let index = Int (scrollView.contentOffset.x / scrollView.width)
        
        
        let btn = btnArr[index] as?UIButton
        
       btn!.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        
        UIView.animateWithDuration(0.25, animations: {
        }) { (_) in
            //指示器跟随滚动
            
            UIView.animateWithDuration(0.25, animations: {
                self.indicatorView.center = CGPoint(x: btn!.center.x, y: self.indicatorView.center.y)
            })
            
            
        }
        
        let botoomView = contentScroll.subviews[index]
        
      
        
        botoomView.frame = scrollView.bounds
        
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    

}
