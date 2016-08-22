//
//  LLChannel_groupsModel.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLChannel_groupsModel: NSObject {
    
    var id:Int = -1
    /// 子数组
    var channels:NSArray?
    /// 标题
    var name:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }


}
