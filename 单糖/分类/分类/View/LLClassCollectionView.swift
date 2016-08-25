//
//  LLClassCollectionView.swift
//  单糖
//
//  Created by JYD on 16/8/22.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClassCollectionView: UICollectionView {

   /// 模型数组
    private  var projuectArr = [LLProjectModel]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        
        registerClass(LLProjectCollectionViewCell.self, forCellWithReuseIdentifier: "LLClassCollectionView")
        
        loadDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func loadDate() {
        
        
        let urlString = baseUrl + "v1/collections?limit=20&offset=0"
        
        LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
            
            
            let dateDict = (backDate as? NSDictionary)?.objectForKey("data")
            
            guard  let collectionsArr = dateDict?.objectForKey("collections") as? NSArray else {
                
                
            return
            }
            
            for index in 0..<collectionsArr.count {
                
                let model = LLProjectModel(dict: collectionsArr[index] as! [String : AnyObject])
                
                self.projuectArr.append(model)
                
                self.reloadData()
            
            
            }
            
        }
    
    
    }
    

}



extension LLClassCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
      func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return projuectArr.count
    
    
    }
    
   
 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LLClassCollectionView", forIndexPath: indexPath) as? LLProjectCollectionViewCell
        
        cell!.model = projuectArr[indexPath.row]
               
        return cell!
    
    
    }
    
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        //UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //发送通知控制控制器跳转
        let model = projuectArr[indexPath.row]
        
        NSNotificationCenter.defaultCenter().postNotificationName(LLSpecialCollectionNotication, object: model)
        
    }
    
  
    


}
