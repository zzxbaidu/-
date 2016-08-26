//
//  LLItemController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
class LLItemController: LLBaseController {

    
     let cellReuseIdentifier = "LLItemController"
    
    /// 上拉下拉的标题
    var offset:Int = 0;
    /// 保存所有数据
    var statuses: [LLItemModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
    loadDate()
      setupUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // MARK: ---- 添加 UI 数据
    private func setupUI() {
    view.addSubview(itemCollectionView)
        
    itemCollectionView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        //添加下拉刷新
        
        weak   var weakSelf = self
        let headRresh = LLRefreshGifHeader.headerWithRefreshingBlock {
            //下拉刷新
            weakSelf!.offset = 0;
            weakSelf?.loadDate()
            } as! LLRefreshGifHeader
        headRresh.gifView?.frame = CGRectMake(0, 30, 100, 100)
        itemCollectionView.mj_header = headRresh
        
        //添加上拉加载
        
        itemCollectionView.mj_footer = MJRefreshBackNormalFooter.footerWithRefreshingBlock({
            
            weakSelf!.offset += 1;
            weakSelf?.loadDate()
            
        }) as? MJRefreshBackNormalFooter
        

    }
          // MARK: ---- 请求数据
    private func loadDate() {
        
    let urlString = baseUrl + "v2/items?gender=1&generation=1&limit=20&offset=0"
        LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
            
            let objectDict = backDate as?NSDictionary
            
            let dataDict = objectDict?.objectForKey("data") as? NSDictionary
            
            guard let itemArr  = dataDict?.objectForKey("items") as? NSArray else {
               SVProgressHUD.showInfoWithStatus("请求数据失败")
            
            return
            }
            
           var models = [LLItemModel]()
            for index in 0..<itemArr.count {
                
                let itemDict = itemArr[index] as?NSDictionary
                
                let item  = itemDict?.objectForKey("data") as? [String : AnyObject]
                
                let model =  LLItemModel(dict: item! )
                models.append(model)
            
            }
            
            // 3.处理下拉刷新的数据
            if self.offset == 0
            {
                // 将新的数据凭借到旧数据前面
                self.statuses == nil ?  (self.statuses = models) :  (self.statuses = models + self.statuses!)
                
                
                // self.statuses = models + self.statuses!
                
            }else if self.offset != 0
            {
                // 将新的数据拼接到旧数据后面
                self.statuses = self.statuses! + models
            }
            
               self.itemModelArr = NSMutableArray(array: self.statuses!)
            
            self.itemCollectionView.mj_header.endRefreshing()
            self.itemCollectionView.mj_footer.endRefreshing()
            self.itemCollectionView.reloadData()
        }
    
    
    }
    
    // MARK: ---- 懒加载
    
    
    private lazy var itemCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
       
        
        
        
        
        layout.itemSize = CGSizeMake( (SCREEN_WITH - 24) / 2, 220)
        
        let colletion = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        colletion.backgroundColor = UIColor.whiteColor()
        
        colletion.registerClass(LLItemnCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        
        
        colletion.dataSource = self
        colletion.delegate = self
        return colletion
        
    }()
    
    
    private lazy var itemModelArr:NSMutableArray = NSMutableArray(capacity: 1)

    
}

extension LLItemController :UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemModelArr.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as? LLItemnCell
        
        let model = itemModelArr[indexPath.row] as? LLItemModel
        
        cell!.model = model
        
        
        return cell!
        
    }
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        //UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
        return UIEdgeInsetsMake(12, 5, 12, 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailVc = LLDeatilItemController()
        detailVc.title = "商品详情"
        detailVc.model = itemModelArr[indexPath.row] as? LLItemModel
        self.navigationController?.pushViewController(detailVc, animated: true)
    }

}