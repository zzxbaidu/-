//
//  LLClasDetailCell.swift
//  单糖
//
//  Created by JYD on 16/8/25.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClasDetailCell: UITableViewCell {

    
    var bgImageView:UIImageView?
    
    var likeButton:UIButton?
    var titleLable:UILabel?
    var model:LLChidrenModel? {
        
        didSet {
            
            bgImageView?.sd_setImageWithURL(NSURL(string: (model?.cover_image_url)! as String), placeholderImage: UIImage(named: "Me_ProfileBackground"))
            
            
            guard let likeCount = model?.likes_count else {
                return
            }
            likeButton?.setTitle(String( likeCount), forState: .Normal)
            guard let title = model?.title else {
                return
            }
            titleLable?.text = String (title)
            
        }
        
    }
    
    var searchModel:LLSearchCollectionModel? {
        
        didSet {
            bgImageView?.sd_setImageWithURL(NSURL(string: (model?.cover_image_url)! as String), placeholderImage: UIImage(named: "Me_ProfileBackground"))
            
            
            guard let likeCount = model?.likes_count else {
                return
            }
            likeButton?.setTitle(String( likeCount), forState: .Normal)
            guard let title = model?.title else {
                return
            }
            titleLable?.text = String (title)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        bgImageView = UIImageView()
        bgImageView!.layer.masksToBounds = true
        bgImageView!.layer.cornerRadius = 7
        contentView.addSubview(bgImageView!)
        
        bgImageView?.snp_makeConstraints(closure: { (make) in
            
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView).offset(5)
            make.right.equalTo(self.contentView).offset(-5)
            make.bottom.equalTo(self.contentView).offset(-5)
            
            
        })
        
        
        let likeView = UIView()
        bgImageView?.addSubview(likeView)
        likeView.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(12)
            make.right.equalTo(self.contentView).offset(-12)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        likeView.alpha = 0.8;
        likeView.layer.masksToBounds = true
        likeView.layer.cornerRadius = 7
        likeView.backgroundColor = UIColor.darkGrayColor()
        
        likeButton = UIButton(type: .Custom)
        likeButton?.titleLabel?.font = UIFont.systemFontOfSize(11)
        likeView.addSubview(likeButton!)
        
        likeButton!.snp_makeConstraints { (make) in
            
            make.centerX.centerY.equalTo(likeView)
        }
        
        likeButton!.setImage(UIImage(named: "Feed_FavoriteIcon_17x17_"), forState: .Normal)
        
        
        titleLable = UILabel()
        titleLable?.font = UIFont.systemFontOfSize(16)
        titleLable?.textColor = UIColor.whiteColor()
        bgImageView?.addSubview(titleLable!)
        
        titleLable?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(bgImageView!).offset(12)
            make.bottom.equalTo(bgImageView!).offset(-12)
        })
        
        
    }
    
}
