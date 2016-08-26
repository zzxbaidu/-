//
//  LLSeachCell.swift
//  单糖
//
//  Created by JYD on 16/8/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLSeachCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 7
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = LLColor(240, g: 240, b: 240, a: 1.0).CGColor
        contentView.addSubview(nameLable)
        
        nameLable.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var nameLable:UILabel =  {
    
        let lable = UILabel()
        
        lable.font = UIFont.systemFontOfSize(13)
        lable.numberOfLines = 1
        lable.textColor = UIColor.darkGrayColor()
        
        return lable
    
    }()
    
}
