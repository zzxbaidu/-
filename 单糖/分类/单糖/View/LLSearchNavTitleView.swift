//
//  LLSearchNavTitleView.swift
//  单糖
//
//  Created by JYD on 16/8/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLSearchNavTitleView: UIView {

    //类似于OC中的typedef 回调按钮的点击方法
    typealias callback = (searchField:UITextField )->Void
    
    /// 按钮的回调方法
    var searchCallBack:callback?
    init(frame: CGRect,block:callback) {
        super.init(frame: frame)
        
        searchCallBack = block
        setupUI()
        backgroundColor = UIColor(colorLiteralRed: 217 / 255.0, green: 217 / 255.0, blue: 217 / 255.0, alpha: 0.8)
        layer.masksToBounds = true
        layer.cornerRadius = 7.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textFieldNotifaction(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
          // MARK: ---- 接收UITextField的通知方法
    
    @objc private func textFieldNotifaction(note:NSNotification) {
    
        searchCallBack!(searchField: searchField)
              
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    
    }
    
    
          // MARK: ---- 添加UI 视图
    
    private func setupUI() {
        
        
       let  serachView = UIImageView(image: UIImage(named: "Feed_SearchBtn_18x18_"))
        addSubview(serachView)
        
        serachView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        addSubview(searchField)
        searchField.snp_makeConstraints { (make) in
            make.left.equalTo(serachView.snp_right).offset(2)
            make.centerY.equalTo(self)
            make.width.equalTo(self.width - serachView.width)
        }
    
    
    
    }
    
          // MARK: ---- 懒加载一些控件
    
    private lazy var searchField:UITextField =  {
    
        let field = UITextField()
        field.placeholder = "搜索商品. 专题"
        field.returnKeyType = .Search
        field.delegate = self
        return field
    
    }()

}

extension LLSearchNavTitleView:UITextFieldDelegate {
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
       
        return true
    }


}


