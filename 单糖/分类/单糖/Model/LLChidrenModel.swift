//
//  LLChidrenModel.swift
//  单糖
//
//  Created by JYD on 16/8/16.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLChidrenModel: NSObject {
/// 详情页
     var content_url:NSString?
    /// cell 配图
     var cover_image_url:NSString?
    /// 喜欢人数
    var likes_count:Int = -1
    /// 分享介绍
    var share_msg:NSString?
/// 详情页标题
     var short_title:NSString?
    /// cell 标题
     var title:NSString?
    
    /// 详情页
    var url:NSString?
    
    init(dict:[String:AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }


}
