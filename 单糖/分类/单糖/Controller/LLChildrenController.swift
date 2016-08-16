//
//  LLChildrenController.swift
//  单糖
//
//  Created by JYD on 16/8/12.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLChildrenController: UITableViewController {

    
   
    var titleId:Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(titleId)
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 请求数据
    
    
    
      // MARK: ---- 懒加载
    
    
    lazy var childrenArr = [LLChidrenModel]()
}
