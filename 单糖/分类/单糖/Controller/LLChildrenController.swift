//
//  LLChildrenController.swift
//  单糖
//
//  Created by JYD on 16/8/12.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
class LLChildrenController: UITableViewController {

    
   
    var titleId:Int = -1
    
    let cellIdentifier = "LLChildrenController"
    override func viewDidLoad() {
        super.viewDidLoad()
    
       getChildrenDate()
       tableView.registerClass(LLChliddrenCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 请求数据
    
    private func getChildrenDate() {
        
    let  urlString = baseUrl + "v1/channels/\(titleId)/items?gender=1&generation=1&limit=20&offset=0"
    
    LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
       
        let dateDict = backDate as?NSDictionary
        guard let dateArr = dateDict?.objectForKey("data") as?NSDictionary else {
            SVProgressHUD.showErrorWithStatus("加载失败,请重试")
            return
        }
        
        let dateItemArr = dateArr.objectForKey("items")as?NSArray
        
        for index in 0..<dateItemArr!.count {
            
            let model =  LLChidrenModel(dict: dateItemArr![index] as! [String : AnyObject])
            
            self.childrenArr.addObject(model)
        
        }
        
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
        
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    

   
    
  
    

}
