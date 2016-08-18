//
//  LLSearchCollectionModel.swift
//  单糖
//
//  Created by JYD on 16/8/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLSearchCollectionModel: NSObject {

    
    var id:Int = -1
    /// 喜欢人数
     var likes_count:Int = -1
    /// 配图
    var cover_image_url:String?
    /// 标题
    var name:String?
    /// 价格
    var price:String?
    
    /// 标题
    var title:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
