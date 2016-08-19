//
//  LLCommentsView.swift
//  单糖
//
//  Created by JYD on 16/8/19.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLCommentsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scroll)
        
        backgroundColor = UIColor.whiteColor()
        
        let bgImageView = UIImageView(image: UIImage(named: "icon_nosignal_94x104_"))
        
        scroll.addSubview(bgImageView)
        
        bgImageView.snp_makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }
        
        //let lable = UILabel()
        
        
        
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 懒加载
    lazy var scroll:UIScrollView = {
        
        let scr = UIScrollView()
        scr.frame =  self.bounds
        return scr
    
    }()

}
