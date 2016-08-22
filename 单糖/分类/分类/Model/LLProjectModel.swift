

//
//  LLProjectModel.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLProjectModel: NSObject {
    
    var id:Int = -1
    /// 喜欢人数
    var posts_count:Int = -1
    /// 配图
    var banner_image_url:String?
    /// 标题
    var cover_image_url:String?
    /// 子标题
    var subtitle:String?
    /// 商品描述
    var title:String?
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }


}
