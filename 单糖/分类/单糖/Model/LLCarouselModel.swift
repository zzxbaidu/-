//
//  LLCarouselModel.swift
//  单糖
//
//  Created by 周尊贤 on 16/8/14.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLCarouselModel: NSObject {
    
    /// 轮播图
    var image_url:String?
    /// 图片的id
     var id:Int = -1
    /// 图片点击的字典
      var target:NSDictionary?
    /// 横幅图
      var banner_image_url:String?
    /// 覆盖图
     var cover_image_url:String?
    /// 帖子数
    var posts_count:Int = -1
    /// 字幕标题
    var subtitle:Int = -1
    /// 点进去的标题
    var title:Int = -1
/// 图片点进入的ID
    var target_id:Int = -1
    
    init(dict:[String:AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

    

}
