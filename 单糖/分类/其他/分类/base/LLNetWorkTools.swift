//
//  LLNetWorkTools.swift
//  单糖
//
//  Created by JYD on 16/8/12.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LLNetWorkTools: NSObject {
    
    /// 创建一个单利
  static let sharedTools = LLNetWorkTools()
    
    //类似于OC中的typedef 回调按钮的点击方法
  typealias callbackArr = (backDate:AnyObject )->Void
    
    
    /**
     封装一个 get 请求
     
     - parameter urlStr:   请求的 url
     - parameter param:     参数
     - parameter finished: 完成的回调 
     */
     func loadGETDate(urlStr:String,param:AnyObject,finished:callbackArr) {
    
        let url = NSURL(string: urlStr)
    
        SVProgressHUD.showWithStatus("拼命加载中...")

        Alamofire.request(.GET, url!, parameters: param as? [String : AnyObject])
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    
                    finished(backDate: JSON)
                }else {
                SVProgressHUD.showErrorWithStatus("加载失败,请重试")
                
                }
                
                SVProgressHUD.dismiss()
        }
    
    }
    
    
}
