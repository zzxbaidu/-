//
//  LLDeatilItemController.swift
//  单糖
//
//  Created by JYD on 16/8/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLDeatilItemController: LLBaseController {

    /// 模型数组
    var model:LLItemModel?
    override func viewDidLoad() {
        super.viewDidLoad()

     
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: #selector(LLDeatilItemController.rigthItemClick))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 添加子视图
    private func setupUI() {
    
        
    
    }
    
          // MARK: ---- 按钮的点击方法
    
    @objc private func rigthItemClick() {
    
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
