//
//  LLLoginViewController.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLLoginViewController: LLBaseController {

    
    var passWordFiled:UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = LLColor(240, g: 240, b: 240, a: 1.0)
        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldNotification(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
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
        
        passWordFiled?.text != "" ? (loginButton.backgroundColor = UIColor.redColor()) : (loginButton.backgroundColor = UIColor.brownColor())
        
        
    }

       // MARK: ---- 添加 UI 视图
    private func setupUI() {
        
        //添加导航
        
    weak var weakSelf = self
   let navView = LLCustermNavView(frame: CGRectZero, type: 4, title: "登录") { (leftButton) in
    if leftButton.tag == 1 {
        
    weakSelf!.dismissViewControllerAnimated(true, completion: nil)
    }else {
        
     self.presentViewController(LLRegisteController(), animated: true, completion: nil)
    
    }
        }
    view.addSubview(navView)
        navView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(64)
        }
        
    navView.backgroundColor = UIColor.redColor()
        
       //登录和注册容器
        
    let contenView = UIView()
     contenView.backgroundColor = UIColor.whiteColor()
    view.addSubview(contenView)
        
        contenView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(navView.snp_bottom).offset(30)
            make.height.equalTo(90)
        }
        
        
        //手机号
        let phonTextFild = UITextField()
        contenView.addSubview(phonTextFild)
        phonTextFild.placeholder = "手机号"
        phonTextFild.snp_makeConstraints { (make) in
            make.left.equalTo(contenView).offset(12)
            make.right.equalTo(contenView).offset(-12)
            make.top.equalTo(contenView)
            make.height.equalTo(44)
        }
        
        //分割线
        let lineView = UIView()
        
        contenView.addSubview(lineView)
        
        lineView.backgroundColor = LLColor(240, g: 240, b: 240, a: 1.0)
        
        lineView.snp_makeConstraints { (make) in
            make.left.equalTo(contenView).offset(12)
            make.right.equalTo(contenView).offset(-12)
            make.top.equalTo(phonTextFild.snp_bottom).offset(1)
            make.height.equalTo(1)
        }
        
        //密码
        let passWordFild = UITextField()
        
        passWordFiled = passWordFild
        contenView.addSubview(passWordFild)
        passWordFild.placeholder = "密码"
        passWordFild.snp_makeConstraints { (make) in
            make.left.equalTo(contenView).offset(12)
            make.right.equalTo(contenView).offset(-12)
            make.top.equalTo( lineView.snp_bottom)
            make.height.equalTo(44)
        }
        
        //登录按钮
        view.addSubview(loginButton)
        
        loginButton.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
            make.top.equalTo(contenView.snp_bottom).offset(30)
            make.height.equalTo(40)
        }
        
       //忘记密码
        
        view.addSubview(forgetButton)
        forgetButton.snp_makeConstraints { (make) in
            make.right.equalTo(loginButton.snp_right)
            make.top.equalTo(loginButton.snp_bottom).offset(20)
        }
        
        //其他账号登录
        
        let lable = UILabel()
        view.addSubview(lable)
        lable.text = "--------------  使用社交账号登录  --------------"
        lable.font = UIFont.systemFontOfSize(12)
        lable.textColor = UIColor.darkGrayColor()
        lable.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(forgetButton.snp_bottom).offset(20)
        }
        
        
        //底部的 veiw
        
        let bootomView = UIView()
        
        view.addSubview(bootomView)
        
    bootomView.snp_makeConstraints { (make) in
        make.left.right.equalTo(view)
        make.top.equalTo(lable.snp_bottom).offset(30)
        
        make.height.equalTo(120)
        }
        
        //循环创建撒呢过按钮
        
        for index in 0..<3 {
            
            let maxCols = 3
            
            let buttonW: CGFloat = (SCREEN_WITH / CGFloat (maxCols) - 45)
            
            let buttonH: CGFloat = buttonW
            let buttonStartX: CGFloat = 16
            let xMargin: CGFloat = (SCREEN_WITH   - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
            
            let button = YMVerticalButton()
            button.tag = index
            button.setImage(UIImage(named: imageNameArr[index]), forState: .Normal)
            button.width = buttonW
            button.height = buttonH
            button.addTarget(self, action: #selector(bottomButtonClick(_:)), forControlEvents: .TouchUpInside)
            
            // 计算 X、Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            bootomView.addSubview(button)
        }

        
    }
    
    @objc private func bottomButtonClick(btn:UIButton) {
    
    }
    
          // MARK: ---- 懒加载
    
    
    private lazy var imageNameArr = ["Share_WeiboIcon_70x70_","Share_WeChatSessionIcon_70x70_","Share_QQIcon_70x70_"]
    
    private lazy var loginButton:UIButton = {
        
        let btn = UIButton(type: .Custom)
        btn.setTitle("登录", forState: . Normal)
        btn.backgroundColor = UIColor.brownColor()
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 7
        
        return btn
    
    }()
    
    private lazy var forgetButton:UIButton = {
        
        let btn = UIButton(type: .Custom)
        btn.setTitle("忘记密码", forState: . Normal)
      btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        return btn
        
    }()


    }
