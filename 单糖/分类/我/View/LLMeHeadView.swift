//
//  LLMeHeadView.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLMeHeadView: UIView {

    //类似于OC中的typedef 回调按钮的点击方法
    typealias buttonClick = (btn:UIButton )->Void
    
    
    var btnClick:buttonClick?
    init(frame: CGRect ,btnBlock:buttonClick) {
        super.init(frame: frame)
        
        btnClick = btnBlock
        setupUI()
        
        backgroundColor = LLColor(240, g: 240, b: 240, a: 0.8)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 添加子视图
    
    private func setupUI() {
        
        //头部背景图
    let bgImageView  = UIImageView(image: UIImage(named: "Me_ProfileBackground"))
        bgImageView.userInteractionEnabled = true
        addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(self).offset(-15)
        }
        
    //用户头像
        let personbutton = LLCustemButton(type: .Custom)
        bgImageView.addSubview(personbutton)
        
        personbutton.tag = 1
        personbutton.setImage(UIImage(named: "Me_AvatarPlaceholder_75x75_"), forState: .Normal)
        personbutton.setTitle("登录", forState: .Normal)
        personbutton.addTarget(self, action: #selector(buttoClick(_:)), forControlEvents: .TouchUpInside)
        personbutton.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        //左边按钮
        
        let leftButton = UIButton(type: .Custom)
         leftButton.addTarget(self, action: #selector(buttoClick(_:)), forControlEvents: .TouchUpInside)
        leftButton.tag = 2
        bgImageView.addSubview(leftButton)
        leftButton.setImage(UIImage(named: "Me_message_20x20_"), forState: .Normal)
        leftButton.snp_makeConstraints { (make) in
            make.left.equalTo(bgImageView).offset(20)
            make.top.equalTo(bgImageView).offset(30)
        }
        //右边按钮
        
        let rightButton = UIButton(type: .Custom)
         rightButton.addTarget(self, action: #selector(buttoClick(_:)), forControlEvents: .TouchUpInside)
        rightButton.tag = 3
        bgImageView.addSubview(rightButton)
        rightButton.setImage(UIImage(named: "Me_settings_20x20_"), forState: .Normal)
        rightButton.snp_makeConstraints { (make) in
            make.right.equalTo(bgImageView).offset(-20)
            make.top.equalTo(bgImageView).offset(30)
        }

      
    
    }
    
          // MARK: ---- 按钮的点击方法
    
   @objc private func buttoClick(btn:UIButton)
    {
     btnClick!(btn: btn)
    }

}
