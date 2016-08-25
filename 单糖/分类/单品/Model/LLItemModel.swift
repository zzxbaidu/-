//
//  LLItemModel.swift
//  单糖
//
//  Created by JYD on 16/8/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLItemModel: NSObject {
    
    var id:Int = -1
    /// 喜欢人数
    var favorites_count:Int = -1
    /// 配图
    var cover_image_url:String?
    /// 标题
    var name:String?
    /// 价格
    var price:String?
    /// 配图数组
    var image_urls:NSArray?
    
    /// 标题
    var title:String?
    /// 图文介绍 URL
     var url:String?
    /// 购买链接
     var purchase_url:String?
    /// 商品描述
     var descriptio:String?
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
       
        if key == "description" {
           
            descriptio = value as? String
            
            return
        }
        
         super.setValue(value, forKey: key)

    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
