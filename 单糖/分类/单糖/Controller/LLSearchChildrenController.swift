//
//  LLSearchChildrenController.swift
//  单糖
//
//  Created by JYD on 16/8/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
class LLSearchChildrenController: LLBaseController {

    
    var childControllerIndex:Int?
    
     let cellReuseIdentifier = "LLSearchChildrenController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(serachNotifaction(_:)), name: LLSeachNotification, object: nil)
        
        if childControllerIndex == 0 {
            
            setupGoodsUI()
        }else {
        setupProjectUI()
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
          // MARK: ---- 搜索的通知方法
    
    @objc private func serachNotifaction(note:NSNotification) {
        
        print( note.object)
        
        let key = note.object as? String
        
        getSearchDate(key!)
        
        
    }
    
    func getSearchDate(searchStr:NSString){
        let key =  searchStr
        guard let codeString = key.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) else {
            return
        }
        
        var url = baseUrl
        
        if childControllerIndex == 0 {
            url = url + "v1/search/item?keyword=\(codeString)&limit=20&offset=0&sort="
        }else {
            url = url + "v2/search/post?keyword=\(codeString)&sort=&offset=0&limit=20"
        }
        
        LLNetWorkTools.sharedTools.loadGETDate(url, param: "") { (backDate) in
            
            
            let objectDict = backDate as? NSDictionary
            
            let dataDict = objectDict?.objectForKey("data") as? NSDictionary
            
            if self.childControllerIndex == 0 {
                guard  let itemArr = dataDict?.objectForKey("items") as? NSArray else {
                    SVProgressHUD.showInfoWithStatus("暂无数据")
                    return
                }
                
                var models = [LLSearchCollectionModel]()
                for index in 0..<itemArr.count {
                    
                    let model =  LLSearchCollectionModel(dict: itemArr[index] as! [String : AnyObject])
                    models.append(model)
                }
                if models .count > 0{
                    self.itemArr = NSMutableArray(array: models)
                    
                    self.goodsCollection.reloadData()
                    
                }
                
            }else {
                guard  let itemArr = dataDict?.objectForKey("posts") as? NSArray else {
                    SVProgressHUD.showInfoWithStatus("暂无数据")
                    return
                }
                
                var models = [LLSearchCollectionModel]()
                for index in 0..<itemArr.count {
                    
                    let model =  LLSearchCollectionModel(dict: itemArr[index] as! [String : AnyObject])
                    models.append(model)
                }
                
                if models .count > 0{
                    self.itemArr = NSMutableArray(array: models)
                    self.projectTabView.reloadData()
                }
            }
            
        }
        

    }
    
          // MARK: ---- 添加商品的数据和 UI
    
    
    private func setupGoodsUI() {
        
        view.addSubview(goodsCollection)
        
        goodsCollection.snp_makeConstraints { (make) in
           make.left.right.top.bottom.equalTo(self.view)
        }
        
      
        
    
    }
          // MARK: ---- 添加专题的数据和 UI
    private func setupProjectUI() {
        
        view.addSubview(projectTabView)
        
        projectTabView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        
    }

        // MARK: ---- 懒加载
    
    
    private lazy var goodsCollection:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSizeMake( (SCREEN_WITH - 24) / 2, 220)
        
        let colletion = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            colletion.backgroundColor = UIColor.whiteColor()
     
            colletion.registerClass(LLSearchCollectionViewCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        

        colletion.dataSource = self
        colletion.delegate = self
        return colletion
    
    }()
    
    
    private lazy var projectTabView:UITableView = {
    
        let tabView = UITableView(frame: self.view.bounds, style: .Plain)
        tabView.registerClass(LLSearchTableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        tabView.dataSource = self
        tabView.delegate = self
        
        let footView = UIView()
        tabView.tableFooterView = footView
        return tabView
    }()
    
    /// 存放模型数组
    private lazy var itemArr:NSMutableArray = NSMutableArray(capacity: 1)


}

extension LLSearchChildrenController:UICollectionViewDataSource,UICollectionViewDelegate {

     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return itemArr.count
    }
    
   
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as? LLSearchCollectionViewCell
        
        let model = itemArr[indexPath.row] as? LLSearchCollectionModel
        
        cell!.model = model
        
        
        return cell!
    
    }
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        //UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
        return UIEdgeInsetsMake(12, 5, 12, 5)
    }

}

extension LLSearchChildrenController:UITableViewDataSource,UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemArr.count
    
    }
    
 
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as? LLSearchTableViewCell
        
        let model = itemArr[indexPath.row] as? LLSearchCollectionModel
        
        cell!.searchModel = model
        
        return cell!
    
    
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 180
    }

}
