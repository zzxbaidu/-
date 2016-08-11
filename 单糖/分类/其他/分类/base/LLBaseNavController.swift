//
//  LLBaseNavController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLBaseNavController: UINavigationController {

    
    var popDelegate:UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        popDelegate = interactivePopGestureRecognizer?.delegate
        interactivePopGestureRecognizer?.delegate = nil
        
        self.delegate = self
        
        navigationBar.barStyle = .Default
      
        
        navigationBar.barTintColor = UIColor.redColor()
        
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func backButton() {
    
        popViewControllerAnimated(true)
    }
    
    /**
     管理状态栏文字的颜色
     
     - returns: LightContent
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
    }


}

extension LLBaseNavController:UINavigationControllerDelegate {
    // 导航控制器跳转完成的时候调用
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        if viewController == viewControllers[0] {
            interactivePopGestureRecognizer?.delegate = popDelegate
        }else {
        
        interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
         // 设置非根控制器导航条内容
        if viewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let btn = UIButton(type: .Custom)
            btn.setBackgroundImage(UIImage(named: "checkUserType_backward_9x15_"), forState: .Normal)
              btn.setBackgroundImage(UIImage(named: "checkUserType_backward_9x15_"), forState: .Highlighted)
            btn.sizeToFit()
            
            btn.addTarget(self, action: #selector(LLBaseNavController.backButton), forControlEvents: .TouchUpInside)
            
            let item = UIBarButtonItem(customView: btn)
            
            viewController.navigationItem.leftBarButtonItem = item
        }
        
         super.pushViewController(viewController, animated: true)
    }

}



