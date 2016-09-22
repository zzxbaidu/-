//
//  AppDelegate.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import IQKeyboardManager
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
              // Override point for customization after application launch.
        
        
        //键盘管理器
        
        
        
        let manager = IQKeyboardManager.sharedManager()
        
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.shouldShowTextFieldPlaceholder = true
        manager.shouldToolbarUsesTextFieldTintColor = true
        manager.enableAutoToolbar = true
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        //获取当前的版本号和上次存储的进行对比
        let isFristOpenApp = LLDownLoadImage.share().isFristStratApp()
        if isFristOpenApp {
            
            let newFeaturesVc = LLNewFeaturesController()
            
            self.window?.rootViewController = newFeaturesVc
            
        }else {
            
        let tabBarVc = LLTabBarController()
        self.window?.rootViewController = tabBarVc
                
            }

        //获取沙河文件
        let imgeString = NSUserDefaults.standardUserDefaults().valueForKey("adImageName")as! String?//objectForKey("adImageName") as! String!
        
        let filePath = LLDownLoadImage.share().getFilePathWithImageName(imgeString)
        
        let isExist = LLDownLoadImage.share().isFileExistWithFilePath(filePath)
        if isExist { //图片存在
            
            let advertiseView = AdvertiseView(frame: self.window!.bounds)
            advertiseView.filePath = filePath
            advertiseView.show()
        }
        
        //无论沙河中是否存在,都需要调用新的广告接口
        LLDownLoadImage.share().getAdvertisingImage()


        return true
        
       
        
    }
        
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

