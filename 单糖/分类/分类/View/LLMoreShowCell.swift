//
//  LLMoreShowCell.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLMoreShowCell: UITableViewCell {

    var model:LLChidrenModel? {
        
        didSet {
            
            bgImage.sd_setImageWithURL(NSURL(string: (model?.cover_image_url)! as String), placeholderImage: UIImage(named: "Me_ProfileBackground"))
            
            
            guard let titlle = model?.title else {
                return
            }
            titleLable.text =  titlle as String
            guard let subtitletitle = model?.subtitle else {
                return
            }
            subtitleLable.text = String (subtitletitle)
            
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
          // MARK: ---- 添加 UI 视图
    private func setupUI() {
        
        contentView.addSubview(bgImage)
        
        bgImage.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(contentView)
        }

        contentView.addSubview(titleLable)
        
        titleLable.snp_makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-5)
        }
        
        let bgView = UIView()
        bgView.alpha = 0.6
        contentView.addSubview(bgView)
        bgView.backgroundColor = UIColor.whiteColor()
        bgView.snp_makeConstraints { (make) in
            make.top.equalTo(titleLable.snp_bottom).offset(12)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
            make.height.equalTo(2)
        }
        
        contentView.addSubview(subtitleLable)
        
        subtitleLable.snp_makeConstraints { (make) in
            make.top.equalTo(bgView).offset(12)
            make.centerX.equalTo(contentView)
            
        }
        
        
    
    }
          // MARK: ---- 懒加载
    private lazy var bgImage:UIImageView = UIImageView()
    
    private lazy var titleLable:UILabel = {
        
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(22)
        lable.textColor = UIColor.whiteColor()
        
        
        return lable
    
    }()
    
    private lazy var subtitleLable:UILabel = {
    
        
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(16)
        lable.textColor = UIColor.whiteColor()
        
        
        return lable
    }()

    
    

}
