//
//  LLSearchController.swift
//  单糖
//
//  Created by JYD on 16/8/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//




import UIKit
import SVProgressHUD
class LLSearchController: LLBaseController {
    /// 设置可视的标题为3个
    let visualCount = 2
    
    var serchStr:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
     view.backgroundColor = UIColor.whiteColor()
     
     automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action:  #selector(rightItenClick))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
      navigationItem.titleView = LLSearchNavTitleView(frame: CGRect(x: 50, y: 0, width: SCREEN_WITH - 100, height: 35), block: { (searchField) in
        
      self.rightSearchClick(searchField.text!)
      })
        
        view.addSubview(serachTabView)
        
        serachTabView.hidden = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ourSeach(_:)), name: LLOurSeachNotication, object: nil)

    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
          // MARK: ---- 取消按钮的点击方法
    
    @objc private func rightItenClick() {
    
    self.navigationController?.popViewControllerAnimated(true)
    }
    
    
          // MARK: ---- 大家都在搜的通知
    @objc private func ourSeach(note:NSNotification) {
        
       print(note.object)
        
        
         serchStr = note.object as?String
        
        rightSearchClick(note.object as! NSString)
        
        
    
    }
    
    @objc private func rightSearchClick(searchName:NSString) {
        
          serchStr = searchName as String
        if searchName.isEqualToString("") {
            
           bgView.hidden = true
            
            view.addSubview(serachTabView)
            serachTabView.hidden = false
            
            
        }else {
            
            serachTabView.removeFromSuperview()
            serachTabView.hidden = true
            bgView.hidden = false
          
            
          
        
             setupUI()
            
            
             NSNotificationCenter.defaultCenter().postNotificationName(LLSeachNotification, object: searchName)
            
        }
        
    }
    
    
          // MARK: ---- 添加 UI 控件
    
    private func setupUI() {
        
        tempTitleArr.removeAllObjects()
        
        for v in titleView.subviews {
            
            v.removeFromSuperview()
            
        }
        
        bgView.frame = view.bounds
        view.addSubview(bgView)
        
        bgView.addSubview(titleView)
        bgView.addSubview(contentScroll)
              
        //添加titleScroll中间的分割线
        
        let dividerView = UIView()
        
        titleView.addSubview(dividerView)
        dividerView.frame = CGRect(x: SCREEN_WITH / 2, y: 0, width: 0.8, height: 44)
        dividerView.alpha = 0.7
        dividerView.backgroundColor = UIColor.darkGrayColor()
        
        //循环添加子控制器
        
        for index in 0..<titleArr.count {
            
            let childVc = LLSearchChildrenController()
            
            let title = titleArr[index]
            
            childVc.childControllerIndex = index
            childVc.title = title
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
            titleView.addSubview(titleLable)
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
    
        
        //设置默认控制器
        guard let fristChildVc = childViewControllers.first as?LLSearchChildrenController  else{
            return
        }
        
        fristChildVc.view.frame = contentScroll.bounds
        fristChildVc.childControllerIndex = 0
        contentScroll.addSubview(fristChildVc.view)
        
        
        //添加指示器 取出第一个 UILable
        let fristLable = tempTitleArr[0] as!UILabel
        indicatorView.frame = CGRect(x: fristLable.x, y: fristLable.y + fristLable.height - 2, width: fristLable.width, height: 2)
        titleView.addSubview(indicatorView)
        
        
      
        

    
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
    
    
    private lazy var serachTabView:LLSearchCollectionView = {
    
  let layout = ZZXCollectionViewFlowLayout()
        let seachView = LLSearchCollectionView(frame: CGRect(x: 0, y: 64, width: SCREEN_WITH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
      
        return seachView
    
    }()
    
    private lazy var bgView = UIView()

    private lazy var titleView:UIView = {
        
        let titleScr = UIView(frame: CGRect(x: 0, y: 64, width: SCREEN_WITH, height: 44))
        titleScr.backgroundColor = UIColor.whiteColor()
           return titleScr
        
    }()
    ///容器视图
    private lazy var contentScroll:UIScrollView = {
        
        let contentScr = UIScrollView(frame: CGRect(x: 0, y: 108, width: SCREEN_WITH, height: SCREEN_HEIGHT - 108))

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
    
    //头部盛装UILable的数组
    
    private lazy var tempTitleArr:NSMutableArray = NSMutableArray(capacity: 1)

    //标题数组
    private lazy var titleArr = ["商品" ,"专题"]
}

// MARK: - UIScrollViewDelegate
extension LLSearchController :UIScrollViewDelegate {
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for view in tempTitleArr {
            
            let tempView = view as!UILabel
            tempView.textColor = UIColor.blackColor()
            
        }
        
        let index = scrollView.contentOffset.x / scrollView.width
        
        
        let lable = tempTitleArr[Int(index)] as!UILabel
        
        lable.textColor = UIColor.redColor()
        
        
        UIView.animateWithDuration(0.25, animations: {
        }) { (_) in
            //指示器跟随滚动
            
            UIView.animateWithDuration(0.25, animations: {
                self.indicatorView.center = CGPoint(x: lable.center.x, y: self.indicatorView.center.y)
            })
            
            
        }
        
        
        
        let Vc = childViewControllers[Int(index)] as?LLSearchChildrenController
        
        contentScroll.addSubview(Vc!.view)
        
        Vc?.childControllerIndex = Int(index)
          Vc!.view.frame = scrollView.bounds
        
        
        //请求专题的数据
        if index == 1 {
            
            guard let seachString = serchStr else {
            return
            }
           Vc?.getSearchDate(seachString)
        }
      
        
        
  
    }
    
  

    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidScroll(scrollView)
    }
    
    
    
    
    
   

}
