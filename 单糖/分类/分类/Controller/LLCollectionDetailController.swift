//
//  LLCollectionDetailController.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
class LLCollectionDetailController: UITableViewController {

    var urlString:String?
    
    /// 区分详情页 1专题合集 2风格 3 查看全部
    var type:Int?
    
    /// 模型数组
    private  var projuectArr = [LLChidrenModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(urlString)

        
    tableView.dataSource = self
    tableView.delegate = self
        
        loadDate()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
          // MARK: ---- 获取数据
    private func loadDate() {
        
        guard  let url = urlString else {
            
            SVProgressHUD.showErrorWithStatus("暂无详情页数据")
            return
        }

        LLNetWorkTools.sharedTools.loadGETDate(url, param: "") { (backDate) in
            
            let dateDict = (backDate as? NSDictionary)?.objectForKey("data")
            if self.type == 1 {
            
            self.GETDate(dateDict!, object: "posts")
                
            }else if self.type == 2 {
                
                self.GETDate(dateDict!, object: "items")
 
            }else if self.type == 3 {
            
            self.GETDate(dateDict!, object: "collections")
            }
            
        }
        
        
       
    
    }
    
    private func GETDate(dateDict:AnyObject ,object:String ) {
        
        guard  let postsArr = dateDict.objectForKey(object) as? NSArray else {
            
            
            return
        }
        
        for index in 0..<postsArr.count {
            
            let model = LLChidrenModel(dict: postsArr[index] as! [String : AnyObject])
            
            self.projuectArr.append(model)
            
            
            
        }

           self.tableView.reloadData()
    }

}

extension LLCollectionDetailController {
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return projuectArr.count

     
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellReusable = ( type != 3 ? "LLCollectionDetailController" : "cellForRowAtIndexPath")
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReusable)
         let model = projuectArr[indexPath.row]
        
        if cell == nil {
            if type != 3 {
                
                cell = LLClasDetailCell(style:.Default, reuseIdentifier: cellReusable)
                
                let ClasDetailCell = cell as! LLClasDetailCell
               
                ClasDetailCell.model = model
                
                
            }else {
                
                cell = LLMoreShowCell(style:.Default, reuseIdentifier: cellReusable)
                
              
                let MoreShowCell = cell as! LLMoreShowCell
                
                MoreShowCell.model = model
                
                
                
            }

        }
        
       
        
       return cell!
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 180
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let model = projuectArr[indexPath.row]
        
        
        
       
        if type == 3 {
            
            let detailVc = LLCollectionDetailController()
            //http://api.dantangapp.com/v1/collections/4/posts?gender=1&generation=0&limit=20&offset=0
             detailVc.urlString = baseUrl + "v1/collections/\(model.id)/posts?gender=1&generation=0&limit=20&offset=0"
            detailVc.type = 1
         
            self.navigationController?.pushViewController(detailVc, animated: true)
            
            
        }else {
            
             let detailVc = LLDetailsController()
            detailVc.titleName =  model.short_title as? String
            
            detailVc.detailUrl = model.content_url as? String
            detailVc.molde = model
         self.navigationController?.pushViewController(detailVc, animated: true)
        }

       
}

}
