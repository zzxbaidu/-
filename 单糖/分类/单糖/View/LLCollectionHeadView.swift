//
//  LLCollectionHeadView.swift
//  单糖
//
//  Created by JYD on 16/8/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLCollectionHeadView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLable)
        
        titleLable.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLable:UILabel =  {
        
        let lable = UILabel()
        
        lable.font = UIFont.systemFontOfSize(13)
        lable.numberOfLines = 1
        lable.textColor = UIColor.darkGrayColor()
        
        return lable
        
    }()
}
