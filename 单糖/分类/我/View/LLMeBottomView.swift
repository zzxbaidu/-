//
//  LLMeBottomView.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLMeBottomView: UIView {

    
      
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        let bgImageView = UIImageView(image: UIImage(named: "Me_blank_50x50_"))
        addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-45)
            make.width.height.equalTo(45)
        }
        
        let textLable = UILabel()
        textLable.text = "登录以享受更多功能"
        addSubview(textLable)
        textLable.snp_makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp_bottom).offset(12)
            make.centerX.equalTo(self)
        }
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
