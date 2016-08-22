//
//  LLClassController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClassController: LLBaseController {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false

      
       
        self.view.addSubview(self.classTabView)
        
        self.classTabView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        self.classTabView.reloadData()
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      // MARK: ---- 懒加载
    private lazy var classTabView:UITableView = {
        
       let tabView = UITableView(frame: CGRectZero, style: .Plain)
        tabView.delegate = self
        tabView.dataSource = self
         tabView.registerClass(LLClasCell.self, forCellReuseIdentifier: "LLClassController")
         tabView.tableFooterView = UIView()
        return tabView
    
    }()
    
    private lazy var classArr:NSArray = ["专题合集","风格"]
}

extension LLClassController:UITableViewDataSource,UITableViewDelegate {
   
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("LLClassController", forIndexPath: indexPath) as?LLClasCell
        

        cell!.titleDate = classArr[indexPath.row] as?String
        
       
        print(classArr[indexPath.row] as?String)
        return cell!
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        if indexPath.row == 0  {
            
            return 120
        }
        return 360
}

}
