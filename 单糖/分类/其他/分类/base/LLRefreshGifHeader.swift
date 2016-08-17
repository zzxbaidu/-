//
//  LLRefreshGifHeader.swift
//  MJReflesh Git动画刷新仿爱鲜蜂
//
//  Created by JYD on 16/7/22.
//  Copyright © 2016年 JYD. All rights reserved.
//

import UIKit
import MJRefresh
class LLRefreshGifHeader: MJRefreshGifHeader {
    
    
    override func prepare() {
        
        super.prepare()
        
        /** 显示刷新状态的label */
        stateLabel.hidden = false
        /** 显示上一次刷新时间的label */
        lastUpdatedTimeLabel.hidden = false
        setImages([UIImage(named: "v2_pullRefresh1")!], forState: .Idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], forState: .Pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], forState: .Refreshing)
        
        setTitle("下拉刷新", forState: .Idle)
        setTitle("松手开始刷新", forState: .Pulling)
        setTitle("正在刷新", forState: .Refreshing)
        
    }

}
