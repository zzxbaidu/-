//
//  LLItemDetailBottomView.swift
//  单糖
//
//  Created by JYD on 16/8/19.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLItemDetailBottomView: UIView {
    
    //类似于OC中的typedef 回调按钮的点击方法
    typealias callbackTarget = (button:UIButton )->Void
    
    /// 按钮的回调方法
    var callBackBolck:callbackTarget?
   
    init(frame: CGRect,buttonBlock:callbackTarget) {
        super.init(frame: frame)
        callBackBolck = buttonBlock
        
        
        backgroundColor = UIColor.brownColor()
        
        alpha = 0.6
        
        let likeButton = UIButton(type: .Custom)
        likeButton.layer.cornerRadius = 5
        likeButton.layer.masksToBounds = true
        likeButton.layer.borderWidth = 2
        likeButton.tag = 1
          likeButton.addTarget(self, action: #selector(buttonClick(_:)), forControlEvents: .TouchUpInside)
        likeButton.layer.borderColor = UIColor.redColor().CGColor
        addSubview(likeButton)
        
        likeButton.setImage(UIImage(named: "content-details_like_16x16_"), forState: .Normal)
        
        likeButton.setImage(UIImage(named: "content-details_like_selected_16x16_"), forState: .Highlighted)
        
        likeButton.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.width.equalTo(SCREEN_WITH /  3)
            make.centerY.equalTo(self)
            make.height.equalTo(34)
        }
        likeButton.setTitle("喜欢", forState: .Normal)
        likeButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        
        let buyButton = UIButton(type: .Custom)
        buyButton.tag = 2
        buyButton.backgroundColor = UIColor.redColor()
        buyButton.layer.cornerRadius = 5
        buyButton.layer.masksToBounds = true
        buyButton.layer.borderWidth = 2
        
        buyButton.layer.borderColor = UIColor.redColor().CGColor
        addSubview(buyButton)
        buyButton.snp_makeConstraints { (make) in
            make.left.equalTo(likeButton.snp_right).offset(12)
           make.right.equalTo(self).offset(-12)
            make.centerY.equalTo(self)
        }
        buyButton.setTitle("去天猫购买", forState: .Normal)
        buyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        buyButton.addTarget(self, action: #selector(buttonClick(_:)), forControlEvents: .TouchUpInside)

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func buttonClick(btn:UIButton) {
    
        if btn.tag == 2 {
            
            callBackBolck!(button: btn)
        }
    
    }

}
