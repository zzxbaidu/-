//
//  LLTabBarController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 添加子控制
    private func addChildViewControllers() {
    
    addChildViewController(LLHomeController(), title: "单糖", imageName: "TabBar_home_23x23_")
        
        addChildViewController(LLItemController(), title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController(LLClassController(), title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController(LLMeController(), title: "我", imageName: "TabBar_me_boy_23x23_")
    
    
    }

          // MARK: ---- 封装添加子控制器方法
    private func addChildViewController(childController:UIViewController ,title:NSString ,imageName:NSString) {
        
        childController.title = title as String
        childController.tabBarItem.image = UIImage(named: imageName as String)
               childController.tabBarItem.selectedImage = UIImage(named: (imageName as String) + "selected")
        
        let navVc  = LLBaseNavController(rootViewController: childController)
        addChildViewController(navVc)

    
    }
    
    
   // - (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
