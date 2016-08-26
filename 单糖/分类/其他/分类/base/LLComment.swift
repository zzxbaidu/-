//
//  LLComment.swift
//  单糖
//
//  Created by JYD on 16/8/12.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD

let  SCREEN_WITH = UIScreen.mainScreen().bounds.size.width

let  SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

let   baseUrl = "http://api.dantangapp.com/"



let LLSeachNotification = "seachNotification"


/// RGBA的颜色设置
func LLColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 间距
let kMargin: CGFloat = 10.0

/// 分类界面 顶部 item 的高
let kitemH: CGFloat = 75
/// 分类界面 顶部 item 的宽
let kitemW: CGFloat = 150
/// 我的界面头部图像的高度
let kYMMineHeaderImageHeight: CGFloat = 200
// 分享按钮背景高度
let kTopViewH: CGFloat = 230


/// 专题合集的通知
let  LLSpecialCollectionNotication = "specialCollectionNotication"


/// 风格的通知
let  LLStyleNotication = "LLStyleNotication"


/// 风格的通知
let  LLCategoryNotication = "LLCategoryNotication"

/// 大家都在搜的通知方法
let  LLOurSeachNotication = "LLOurSeachNotication"
