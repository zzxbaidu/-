//
//  LLClassController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
class LLClassController: LLBaseController {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false


        self.view.addSubview(self.classTabView)
        
        self.classTabView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-44)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(specialCollection(_:)), name: LLSpecialCollectionNotication, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(styleNotification(_:)), name: LLStyleNotication, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(styleNotification(_:)), name: LLCategoryNotication, object: nil)
        
        //添加右边的搜索按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: #selector(self.seacrchClick))
    }
    
    
    // MARK: ---- 搜索按钮的点击方法
    @objc private func seacrchClick() {
        
        
        self.navigationController?.pushViewController(LLSearchController(), animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
          // MARK: ---- 通知的一些方法
    
    @objc private func specialCollection(note:NSNotification) {
        
        print(note.object)
        
        guard  let model = note.object as?LLProjectModel else {
         
        SVProgressHUD.showErrorWithStatus("程序异常,请重试")
            return
        
        }
        
        let detalVc = LLCollectionDetailController()
        
        detalVc.title = model.subtitle
        //http://api.dantangapp.com/v1/collections/4/posts?gender=1&generation=0&limit=20&offset=0
        
       // http://api.dantangapp.com/collections/4/posts?gender=1&generation=0&limit=20&offset=0
        detalVc.urlString = baseUrl + "/v1/collections/\(model.id)/posts?gender=1&generation=0&limit=20&offset=0"
        detalVc.type = 1
        self.navigationController?.pushViewController(detalVc, animated: true)
        
    }
    /**
     分类风格的通知
     */
    @objc private func styleNotification(note:NSNotification) {
    
        guard  let model = note.object  else {
            
            SVProgressHUD.showErrorWithStatus("程序异常,请重试")
            return
            }
        let detalVc = LLCollectionDetailController()
        
        detalVc.type = 2
        
    let titie = (note.userInfo!["modle"] as?NSDictionary)?.objectForKey("name") as?String
        detalVc.title = titie
        
        detalVc.urlString = baseUrl + "v1/channels/\(model)/items?limit=20&offset=0"
        
        self.navigationController?.pushViewController(detalVc, animated: true)
        
    }
    
   
      // MARK: ---- 懒加载
    private lazy var classTabView:UITableView = {
        
       let tabView = UITableView(frame: CGRectZero, style: .Plain)
        tabView.delegate = self
        tabView.dataSource = self
         tabView.registerClass(LLClasCell.self, forCellReuseIdentifier: "LLClassController")
        tabView.separatorStyle = .None
         tabView.tableFooterView = UIView()
        return tabView
    
    }()
    
    private lazy var classArr:NSArray = ["专题合集","风格"]
}
// MARK: - UITableViewDataSource
extension LLClassController:UITableViewDataSource,UITableViewDelegate {
   
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("LLClassController", forIndexPath: indexPath) as?LLClasCell
        
   
        cell!.titleDate = classArr[indexPath.row] as?String
        
        cell?.delegate = self
        
       cell?.selectionStyle = .None
        return cell!
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        if indexPath.row == 0  {
            
            return 120
        }
        return SCREEN_HEIGHT - 120
}

}
// MARK: - 查看更多的代理方法
extension LLClassController:LLClasCellShowMoreButtonDelegate {
    
    func ShowMoreButtonDelegate() {
        
        let detalVc = LLCollectionDetailController()
        
        detalVc.type = 3
        
      detalVc.title = "全部专题"
        detalVc.urlString = baseUrl + "v1/collections?limit=20&offset=0"
        
        self.navigationController?.pushViewController(detalVc, animated: true)

        
    }

}
