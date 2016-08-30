//
//  LLChildrenController.swift
//  单糖
//
//  Created by JYD on 16/8/12.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
class LLChildrenController: UITableViewController {

    
   
    var titleId:Int = -1
    /// 上拉下拉的标题
    var offset:Int = 0;
    /// 保存所有数据
    var statuses: [LLChidrenModel]?

    let cellIdentifier = "LLChildrenController"
    override func viewDidLoad() {
        super.viewDidLoad()
    
       getChildrenDate()
       tableView.registerClass(LLChliddrenCell.self, forCellReuseIdentifier: cellIdentifier)
        
        //添加下拉刷新
        
        weak   var weakSelf = self
        let headRresh = LLRefreshGifHeader.headerWithRefreshingBlock {
            //下拉刷新
            weakSelf!.offset = 0;
            weakSelf?.getChildrenDate()
            } as! LLRefreshGifHeader
        headRresh.gifView?.frame = CGRectMake(0, 30, 100, 100)
        tableView.mj_header = headRresh
        
        //添加上拉加载
        
        tableView.mj_footer = MJRefreshBackNormalFooter.footerWithRefreshingBlock({
            
            weakSelf!.offset += 1;
            weakSelf?.getChildrenDate()
            
        }) as? MJRefreshBackNormalFooter

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 请求数据
    
    private func getChildrenDate() {
        
    let  urlString = baseUrl + "v1/channels/\(titleId)/items?gender=1&generation=1&limit=20&offset=\(offset)"
    
    LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
       
        let dateDict = backDate as?NSDictionary
        guard let dateArr = dateDict?.objectForKey("data") as?NSDictionary else {
            SVProgressHUD.showErrorWithStatus("加载失败,请重试")
            return
        }
        
        let dateItemArr = dateArr.objectForKey("items")as?NSArray
        
         var models = [LLChidrenModel]()
        for index in 0..<dateItemArr!.count {
            
            let model =  LLChidrenModel(dict: dateItemArr![index] as! [String : AnyObject])
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
        
        
        self.childrenArr = NSMutableArray(array: self.statuses!)

        /*
         var models = [LLChidrenModel]()
         for dict in dateItemArr! {
         
         let model = LLChidrenModel(dict: dict as! [String : AnyObject])
         models.append(model)
         
         }
         
         self.childrenArr = models + self.childrenArr!

     */
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
        self.tableView.reloadData()
    
    }
    }
    
      // MARK: ---- 懒加载
    
    
    private lazy var childrenArr:NSMutableArray = NSMutableArray(capacity: 1)
}

extension LLChildrenController {
    
  
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return childrenArr.count
    
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as?LLChliddrenCell
        
        let model = childrenArr[indexPath.row]
        cell?.model = model as? LLChidrenModel
        
        return cell!
    
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 180
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let model = childrenArr[indexPath.row] as?LLChidrenModel
        
        
        let detailVc = LLDetailsController()
        
        detailVc.titleName =  model?.short_title as? String
        
        detailVc.detailUrl = model?.content_url as? String
        detailVc.molde = model
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    

   
    
  
    

}
