//
//  LLClasCell.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClasCell: UITableViewCell {

 
    var titleDate:String? {
        
        didSet {
            
         
            
            titleLable.text = titleDate
            
            if titleDate == "专题合集" {
                showMorebutton.hidden = false
                
                contentView.addSubview(projectCollection)
                projectCollection.snp_makeConstraints(closure: { (make) in
                    make.left.right.equalTo(contentView)
                    make.top.equalTo(titleLable.snp_bottom).offset(5)
                    make.bottom.equalTo(contentView)
                })
                
            }else  {
                
                
              contentView.addSubview(botoomView)
                botoomView.snp_makeConstraints(closure: { (make) in
                    make.left.right.equalTo(contentView)
                    make.top.equalTo(titleLable.snp_bottom).offset(5)
                    make.bottom.equalTo(contentView)
                })
                    
                                       
                
                           
            
            }
        
        }
    
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 添加UI
    private func setupUI() {
        
        contentView.addSubview(titleLable)
        titleLable.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView).offset(12)
        }
        contentView.addSubview(showMorebutton)
        
        showMorebutton.snp_makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-12)
            make.top.equalTo(contentView).offset(12)
        }
        
        

        
        
        
        
        
    
    }
    
    
      // MARK: ---- 懒加载
    private lazy var titleLable:UILabel =  {
        
        let lable = UILabel ()
        
        
        return lable
    
    }()
    
    private lazy var showMorebutton:LLAdjustButton = LLAdjustButton(type: .Custom)

    private lazy var projectCollection:LLClassCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = CGSizeMake(SCREEN_WITH / 2 - 12, 80)
        layout.scrollDirection = .Horizontal
       
        //每个cell之间的间距
        layout.minimumInteritemSpacing = 15.0
        let collection = LLClassCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.whiteColor()
        
        return collection
    
    }()
    
    
    private lazy var botoomView:LLChannelBootomView = LLChannelBootomView()

}
