//
//  LLChannelBootomView.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLChannelBootomView: UIView {

    
    /// 底部模型数组
    private lazy var chanel_Arr = [LLChannel_groupsModel]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let urlString = baseUrl + "v1/channel_groups/all?"
        
        LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
            
            guard   let chanelDict = (backDate as?NSDictionary )?.objectForKey("data") as?NSDictionary else {
                return
            }
            
            let channel_groupsArr = chanelDict.objectForKey("channel_groups")as? NSArray
            
            for index in 0..<channel_groupsArr!.count {
                
                 let model = LLChannel_groupsModel(dict: (channel_groupsArr![index] as? [String : AnyObject])!)
                //let model = LLChannel_groupsModel(dict: (channel_groupsArr![index] as? [String : AnyObject])!)
                
                self.chanel_Arr.append(model)
            }
            
            self.setupUI()
            
        }

        
       
    }
          // MARK: ---- 添加 UI 数据
    private func setupUI() {
        
        //顶部背景色
        let topbgView = UIView()
        topbgView.backgroundColor = UIColor.redColor()
        addSubview(topbgView)
        topbgView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(12)
            make.height.equalTo(12)
        }
        topbgView.backgroundColor = LLColor(240, g: 240, b: 240, a: 1.0)
        
        //取出头部模型数组
        
        let topModel =  chanel_Arr[0]
        
        //头部标题
        let nameTopLable = UILabel()
        addSubview(nameTopLable)
        nameTopLable.text = topModel.name
        nameTopLable.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(topbgView.snp_bottom).offset(15)
        }

        //头部视图
        let topView = UIView()
        addSubview(topView)
        
        topView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(nameTopLable.snp_bottom).offset(12)
            make.height.equalTo(80)
        }
    
        
    for index in 0..<topModel.channels!.count {
        
      let dict = topModel.channels![index] as?NSDictionary
        
        let maxCols = 4
        
        let buttonW:CGFloat = SCREEN_WITH / CGFloat (maxCols)
        let buttonH: CGFloat = buttonW + 20
        let buttonStartX: CGFloat = 5
        let xMargin: CGFloat = (SCREEN_WITH  - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
        
            let button = YMVerticalButton()
            button.tag = index
            button.sd_setImageWithURL(NSURL(string: (dict?.objectForKey("icon_url"))! as! String), forState: .Normal, placeholderImage: UIImage(named: "checkUserType_icon_identity_21x21_"))

           button.setTitle(dict?.objectForKey("name")as?String, forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.width = buttonW
            button.height = buttonH
            button.addTarget(self, action: #selector(topButtonClick(_:)), forControlEvents: .TouchUpInside)
        
            // 计算 X、Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            topView.addSubview(button)

    }
        
        

        
        //底部背景色
        let bootombgView = UIView()
        bootombgView.backgroundColor = UIColor.redColor()
        addSubview(bootombgView)
        bootombgView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(topView.snp_bottom).offset(30)
            make.height.equalTo(12)
        }
        bootombgView.backgroundColor = LLColor(240, g: 240, b: 240, a: 1.0)

        //底部标题
        let titleLable = UILabel()
        
        let bootomModel =  chanel_Arr[1]
        
        addSubview(titleLable)
        
        titleLable.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(bootombgView.snp_bottom).offset(12)
        }
        
        titleLable.text = bootomModel.name
        

              //添加底部的 UI

        let botoomView = UIView()

        addSubview(botoomView)
        
        botoomView.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(titleLable.snp_bottom).offset(12)
            
        }

        for index in 0..<bootomModel.channels!.count {
            
            let dict = bootomModel.channels![index] as?NSDictionary
            
            let maxCols = 4
            
            let buttonW: CGFloat = SCREEN_WITH / CGFloat (maxCols)

            let buttonH: CGFloat = buttonW + 20
            let buttonStartX: CGFloat = 5
            let xMargin: CGFloat = (SCREEN_WITH  - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
            
            let button = YMVerticalButton()
            button.tag = index
            button.sd_setImageWithURL(NSURL(string: (dict?.objectForKey("icon_url"))! as! String), forState: .Normal, placeholderImage: UIImage(named: "checkUserType_icon_identity_21x21_"))
            
            button.setTitle(dict?.objectForKey("name")as?String, forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
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
            botoomView.addSubview(button)
            
        }



    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 按钮的点击方法
    
    @objc private func topButtonClick(btn:UIButton) {
        
        let model = (chanel_Arr[0].channels![btn.tag]) as?NSDictionary
        
        print(model?.objectForKey("id"))
        
        NSNotificationCenter.defaultCenter().postNotificationName(LLStyleNotication, object: model?.objectForKey("id"), userInfo: ["modle":model!])
    
    }
    
    @objc private func bottomButtonClick(btn:UIButton) {
        
        let model = (chanel_Arr[1].channels![btn.tag]) as?NSDictionary
        
        print(model?.objectForKey("id"))
        
          NSNotificationCenter.defaultCenter().postNotificationName(LLCategoryNotication, object: model?.objectForKey("id"), userInfo:  ["modle":model!])
        
    }
}
