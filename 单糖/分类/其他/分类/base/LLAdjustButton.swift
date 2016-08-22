//
//  LLAdjustButton.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLAdjustButton: UIButton {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("查看全部", forState: .Normal)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(11)
        setImage(UIImage(named:"Category_PostCollectionSeeAll_5x8_"), forState: .Normal)
        
        hidden = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.width

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
