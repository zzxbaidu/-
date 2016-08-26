//
//  LLRegisteController.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLRegisteController: LLBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = LLColor(240, g: 240, b: 240, a: 1.0)
        
        setupUI()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldNotification(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    
          // MARK: ---- 接受通知的方法
    
    @objc private func TextFieldNotification(note:NSNotification) {
        
        phoneFild.text != "" ? (smsBtn.backgroundColor = UIColor.redColor()) : (smsBtn.backgroundColor = UIColor.brownColor())
        
    
    }
    
      // MARK: ---- 添加子视图
    
    private func setupUI() {
        
        weak var weakSelf = self
        let navView = LLCustermNavView(frame: CGRectZero, type: 0, title: "注册") { (leftButton) in
            
            weakSelf!.dismissViewControllerAnimated(true, completion: nil)
        }
        
        navView.backgroundColor = UIColor.redColor()
        view.addSubview(navView)
        
        navView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(64)
        }
        
      //提示控件
        let promptLable = UILabel()
        promptLable.text = "请确保你的手机畅通, 已接受验证码短信"
         view.addSubview(promptLable)
        promptLable.textColor = UIColor.darkGrayColor()
        promptLable.font = UIFont.systemFontOfSize(14)
        promptLable.numberOfLines = 1
        promptLable.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(navView.snp_bottom).offset(40)
        }
        
        
        //手机号输入框
        
     
        let phoneView = UIView()
        
        view.addSubview(phoneView)
      phoneView.backgroundColor = UIColor.whiteColor()
        phoneView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(promptLable.snp_bottom).offset(10)
            make.height.equalTo(44)
        }
        
        phoneView.addSubview(phoneFild)
        
        phoneFild.snp_makeConstraints { (make) in
            make.left.equalTo(phoneView).offset(20)
            make.right.equalTo(phoneView).offset(-20)
            make.top.equalTo(phoneView.snp_top)
            make.height.equalTo(phoneView.snp_height)
        }
        
        
        /// 短信验证码
     
        view.addSubview(smsBtn)
        
        smsBtn.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(phoneView.snp_bottom).offset(40)
            make.height.equalTo(35)
        }

    }
    
          // MARK: ---- 懒加载
    
    
    private lazy var smsBtn:UIButton =  {
        
        
        let filed = UIButton()
        filed.backgroundColor = UIColor.brownColor()
        filed.setTitle("获取短信验证码", forState: .Normal)
        filed.layer.masksToBounds = true
        filed.layer.cornerRadius = 7
        filed.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return filed
        
    }()

    
    private lazy var phoneFild:UITextField =  {
    
        
        let filed = UITextField()
        filed.placeholder = "请输入手机号"
        
        
        
        return filed
    
    }()

}
