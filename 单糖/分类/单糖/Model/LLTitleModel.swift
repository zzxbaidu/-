//
//  LLTitleModel.swift
//  单糖
//
//  Created by JYD on 16/8/12.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLTitleModel: NSObject {
    
    var editable:Bool?
    
    var id:Int = -1
    
    var name:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
       }
    
    
    

}
