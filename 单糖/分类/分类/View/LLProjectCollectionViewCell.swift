//
//  LLProjectCollectionViewCell.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLProjectCollectionViewCell: UICollectionViewCell {
    
    var model:LLProjectModel? {
        
        didSet {
            
            bgImageView.sd_setImageWithURL(NSURL(string: model!.banner_image_url!), placeholderImage: UIImage(named: "Me_ProfileBackground"))
            
            guard let title = model?.title else {
            
                return
            }
            
            titieLable.text = title
        
        
        }
    
    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bgImageView)
        
        bgImageView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(contentView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private lazy var bgImageView:UIImageView = UIImageView()
    
    
    private lazy var titieLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(26)
        lable.numberOfLines = 1
        return lable
    
    }()
}
