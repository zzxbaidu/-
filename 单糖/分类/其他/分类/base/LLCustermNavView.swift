//
//  LLCustermNavView.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SnapKit


class LLCustermNavView: UIView {
    //类似于OC中的typedef 回调按钮的点击方法
    typealias letfRightButtonClick = (leftButton:UIButton )->Void
    
    
    var buttonClick:letfRightButtonClick?
    
    var typeMe:Int = -1
    
    /**
     自定义构造方法
     
     - parameter frame: 大小
     - parameter type:  是否为一级页面 一级页面不显示返回按钮
     - parameter block: 按钮的 block
     */
    init(frame: CGRect, type:Int,title: NSString , block:letfRightButtonClick ) {
        super.init(frame: frame)
        typeMe = type
        buttonClick = block
        
        if type != 1 {
         setupBackNavUI()
        }
        
        let titleLable = UILabel()
        addSubview(titleLable)
        titleLable.text = title as String
        
        titleLable.textColor = UIColor.whiteColor()
        
        titleLable.snp_makeConstraints { (make) in
            make.centerY.centerX.equalTo(self)
        }
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
      // MARK: ---- 添加导航栏其他按钮
    private func setupBackNavUI() {
        
        
        
       addSubview(backButton)
        
        if typeMe != 4 {
            backButton.snp_makeConstraints { (make) in
                make.left.top.bottom.equalTo(self)
                make.width.equalTo(100)
                
            }
        }else {
            
            backButton.tag = 1
            backButton.snp_makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.bottom.equalTo(self).offset(-10)
                
                let rightBtn = UIButton(type: .Custom)
                
                rightBtn.tag = 2
                rightBtn.setTitle("注册", forState: .Normal)
                rightBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                 rightBtn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
                
                addSubview(rightBtn)
                rightBtn.snp_makeConstraints(closure: { (make) in
                    make.right.equalTo(self).offset(-10)
                    make.bottom.equalTo(self).offset(-10)
                })
                
            }
        }
       
        
    
    }
    
          // MARK: ---- 懒加载
     lazy var backButton:UIButton = {
        
        let btn = UIButton(type:.Custom)
        
        btn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
        if self.typeMe != 4 {
            let backImageView = UIImageView(image: UIImage(named: "checkUserType_backward_9x15_"))
            btn.addSubview(backImageView)
            
            backImageView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(btn.snp_left).offset(12)
                make.centerY.equalTo(btn)
            })

        }else {
            
            btn.setTitle("取消", forState: .Normal)
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        }
        
        return btn
    
    }()
    
          // MARK: ---- 按钮的点击方法
    @objc private func  btnClick(btn:UIButton) {
        
    
    buttonClick!(leftButton: btn)
    
    }
    
    

    
}
