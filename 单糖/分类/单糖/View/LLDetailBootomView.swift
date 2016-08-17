//
//  LLDetailBootomView.swift
//  单糖
//
//  Created by JYD on 16/8/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLDetailBootomView: UIView {

    //类似于OC中的typedef 回调按钮的点击方法
    typealias callbackTarget = (button:UIButton )->Void
    
    /// 按钮的回调方法
    var callBackBolck:callbackTarget?
    
    var btnIndex0:UIButton?
    var btnIndex1:UIButton?
    var btnIndex2:UIButton?
    var model:LLChidrenModel? {
        
        didSet {
            
            
            guard let likeCount =  model?.likes_count else {
            return
            }
          btnIndex0! .setTitle( String(likeCount), forState: .Normal)
        
            
        }
    
    
    }
    
    var btn:UIButton?
    
    
    
    init(frame: CGRect ,block:callbackTarget) {
        super.init(frame: frame)
        callBackBolck = block
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    
        //循环创建三个按钮
        for index in 0..<3 {
            
            btn = UIButton(type: .Custom)
            addSubview(btn!)
            btn!.tag = index
            btn!.addTarget(self, action: #selector(buttonClick(_:)), forControlEvents: .TouchUpInside)
              btn!.setTitle("10000", forState: .Normal)
            btn!.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
          
             btn!.titleLabel?.font = UIFont.systemFontOfSize(9)

            let buttonW = (SCREEN_WITH - 80 ) / CGFloat (3)
          
            var buttonX = CGFloat (index ) * buttonW + 40
            
            if index == 1 {
                 btnIndex1 = btn
                buttonX =  SCREEN_WITH / 2 - 15
            }else if index == 2 {
                btnIndex2 = btn
            
             buttonX =  SCREEN_WITH - 40 - 30
            } else {
             btnIndex0 = btn
            }
            
           
          btn!.frame = CGRect(x: buttonX, y: 6, width: 30, height: 30)
            if index == 0{
                btn!.setImage(UIImage(named: "Post_FavoriteButton_50x50_"), forState: .Normal)
                btn!.setImage(UIImage(named: "Post_FavoriteButton_Highlighted_50x50_"), forState: .Highlighted)
            }else if index == 1 {
            btn!.setImage(UIImage(named: "Post_ShareButton_50x50_"), forState: .Normal)
            btn!.setImage(UIImage(named: "Post_ShareButton_Highlighted_50x50_"), forState: .Highlighted)
                
            }else {
                btn!.setImage(UIImage(named: "Post_ReplyButton_50x50_"), forState: .Normal)
                btn!.setImage(UIImage(named: "Post_ReplyButton_Highlighted_50x50_"), forState: .Highlighted)
            
            }
            
          
        }
    
    }
    
    @objc private func buttonClick(btn:UIButton) {
        
        print(btn)
        callBackBolck!(button: btn)
    
    }
}
