//
//  LLSettingCell.swift
//  单糖
//
//  Created by JYD on 16/8/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLSettingCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      
        contentView.addSubview(iconImage)
        
        iconImage.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.centerY.equalTo(contentView)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(titileLable)
        
        titileLable.snp_makeConstraints { (make) in
            make.left.equalTo(iconImage.snp_right).offset(16)
            make.centerY.equalTo(iconImage)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 懒加载
     lazy var iconImage:UIImageView = UIImageView()
    
    
     lazy var titileLable:UILabel = {
    
        let lable = UILabel()
        
        lable.font = UIFont.systemFontOfSize(14)
        lable.numberOfLines = 1
        lable.textColor = UIColor.darkGrayColor()
        return lable
    
    }()

}
