//
//  YMActionSheet.swift
//  DanTang
//
//  Created by 杨蒙 on 16/7/23.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit

class YMActionSheet: UIView {
    
       
    class func show() {
        let actionSheet = YMActionSheet()
        actionSheet.frame = UIScreen.mainScreen().bounds
        actionSheet.backgroundColor = LLColor(0, g: 0, b: 0, a: 0.6)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(actionSheet)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(bgView)
        
        bgView.addSubview(cancelButton)
        bgView.addSubview(topView)
        bgView.addSubview(shareButtonView)
        bgView.addSubview(shareLabel)

        topView.addSubview(shareButtonView)
        
        bgView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-12)
            make.height.equalTo(280)
        }
        
        
                cancelButton.snp_makeConstraints { (make) in
                    make.left.equalTo(bgView).offset(kMargin)
                    make.right.equalTo(bgView).offset(-kMargin)
                    make.bottom.equalTo(bgView).offset(-kMargin)
                    make.height.equalTo(44)
                }
        
                topView.snp_makeConstraints { (make) in
                    make.bottom.equalTo(cancelButton.snp_top).offset(-kMargin)
                    make.left.equalTo(cancelButton.snp_left)
                    make.right.equalTo(cancelButton.snp_right)
                    make.height.equalTo(kTopViewH)
                }

                    shareLabel.snp_makeConstraints { (make) in
                    make.left.right.top.equalTo(topView)
                    make.height.equalTo(30)
                }


        
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animateWithDuration(0.25) {
            self.bgView.y = SCREEN_HEIGHT - self.bgView.height
        }
    }
    
    // 底部 view
    private lazy var bgView: UIView = {
        let bgView = UIView()
      
        return bgView
    }()
    // 上部 view
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.whiteColor()
        topView.layer.cornerRadius = 7
        topView.layer.masksToBounds = true
        return topView
    }()
    
    // 分享到标签
    private lazy var shareLabel: UILabel = {
        let shareLabel = UILabel()
        shareLabel.text = "分享到"
        shareLabel.textColor = LLColor(0, g: 0, b: 0, a: 0.7)
        shareLabel.textAlignment = .Center
        return shareLabel
    }()
    // 6个按钮
    private lazy var shareButtonView: YMShareButtonView = {
        let shareButtonView = YMShareButtonView(frame: CGRectZero, buttonClick: { (shareButton) in
            
            let alterView = UIAlertView(title: "提示", message: shareButton.titleLabel?.text, delegate: nil, cancelButtonTitle: "取消")
            
             alterView.show()
        })
        shareButtonView.frame = CGRectMake(0, 30, SCREEN_WITH - 20, kTopViewH - 30)
        return shareButtonView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        cancelButton.setTitleColor(LLColor(37, g: 142, b: 240, a: 1.0), forState: .Normal)
        cancelButton.backgroundColor = UIColor.whiteColor()
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), forControlEvents: .TouchUpInside)
        cancelButton.layer.cornerRadius = 7
        cancelButton.layer.masksToBounds = true
        return cancelButton
    }()
    
    func cancelButtonClick() {
        UIView.animateWithDuration(0.25, animations: {
            self.bgView.y = SCREEN_WITH
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        UIView.animateWithDuration(0.25, animations: {
            self.bgView.y = SCREEN_WITH
            }) { (_) in
                self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
