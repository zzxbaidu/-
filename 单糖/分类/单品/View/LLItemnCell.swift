//
//  LLItemnCell.swift
//  单糖
//
//  Created by JYD on 16/8/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLItemnCell: UICollectionViewCell {
    var model:LLItemModel? {
        
        didSet {
            
            inconImage.sd_setImageWithURL(NSURL(string: (model?.cover_image_url)!), placeholderImage: UIImage(named: "Me_ProfileBackground"))
            
            guard  let title = model?.name else {
                return
            }
            
            titleLable.text =  title
            
            guard let pricre = model?.price else {
                return
            }
            
            priceLable.text = "¥ " + pricre
            
            guard let likeCount = model?.favorites_count else {
                
                return
            }
            
            likeButton.setTitle(String( likeCount), forState: .Normal)
            likeButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 7
        contentView.backgroundColor = UIColor.whiteColor()
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGrayColor().CGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ---- 添加子控件
    private func setupUI() {
        
        contentView.addSubview(inconImage)
        inconImage.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(150)
            
        }
        
        contentView.addSubview(titleLable)
        titleLable.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(5)
            make.right.equalTo(self.contentView).offset(-5)
            make.top.equalTo(inconImage.snp_bottom).offset(12)
            
        }
        
        contentView.addSubview(priceLable)
        priceLable.snp_makeConstraints { (make) in
            make.left.equalTo(titleLable.snp_left)
            make.bottom.equalTo(self.contentView).offset(-5)
        }
        
        contentView.addSubview(likeButton)
        likeButton.snp_makeConstraints { (make) in
            make.top.equalTo(priceLable.snp_top)
            make.right.equalTo(titleLable.snp_right)
        }
        
        
    }
    
    /// 图片
    private lazy var inconImage:UIImageView = UIImageView()
    //标题
    private lazy var titleLable:UILabel = {
        
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(12)
        lable.textColor = UIColor.darkGrayColor()
        lable.numberOfLines = 0
        return lable
    }()
    //价钱
    private lazy var priceLable:UILabel = {
        
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(16)
        lable.textColor = UIColor.redColor()
        return lable
    }()
    
    //喜欢
    private lazy var likeButton:UIButton =  {
        
        let btn = UIButton(type: .Custom)
        btn.titleLabel!.font = UIFont.systemFontOfSize(11)
        
        
        btn.setImage(UIImage(named: "Search_GiftBtn_Default_12x10_"), forState: .Normal)
        
        btn.setImage(UIImage(named: "Search_GiftBtn_Selected_12x10_"), forState: .Highlighted)
        
        // btn.setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)
        
        
        btn.contentEdgeInsets =  UIEdgeInsetsMake(0,0, 0, 5);
        return btn
    }()

}
