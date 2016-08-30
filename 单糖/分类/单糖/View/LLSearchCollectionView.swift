//
//  LLSearchTabView.swift
//  单糖
//
//  Created by JYD on 16/8/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//




import UIKit

class LLSearchCollectionView: UICollectionView {

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
 
    super.init(frame: frame, collectionViewLayout: layout)
       
        dataSource = self
        delegate = self
        
        registerClass(LLSeachCell.self, forCellWithReuseIdentifier: "LLSearchTabView")
        registerClass(LLCollectionHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionViewHead")
        
        loadDate()
        
      backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 请求数据
    
    
    private func loadDate() {
        
        let urlString = baseUrl + "v1/search/hot_words?"
        
        LLNetWorkTools.sharedTools.loadGETDate(urlString, param: "") { (backDate) in
            
            let dataDict = ( backDate as? NSDictionary)?.objectForKey("data") as? NSDictionary
            
            
            guard let hot_wordsArr = dataDict?.objectForKey("hot_words") as? NSArray else {
                return
            }
            
           self.hot_wordsArr = NSMutableArray(array: hot_wordsArr)
            
            self.reloadData()
        }
    
    
    }
    
    
          // MARK: ---- 懒加载
    
    private lazy var hot_wordsArr:NSMutableArray = NSMutableArray(capacity: 1)
    
    
    private lazy var headViewArr = ["大家都在搜" ,"搜索历史"]
    
    

}

extension LLSearchCollectionView:UICollectionViewDataSource,UICollectionViewDelegate {
    
   
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return hot_wordsArr.count
        
    }
    
   
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LLSearchTabView", forIndexPath: indexPath) as?LLSeachCell
        
        cell?.nameLable.text = hot_wordsArr[indexPath.item] as? String
        
        
        
        return cell!
    
    
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        
        let str = hot_wordsArr[indexPath.item] as?NSString
        
        let titleSizeName = str?.boundingRectWithSize(CGSizeMake(CGFloat ( MAXFLOAT), CGFloat ( MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12)], context: nil)
        
     return CGSize(width: (titleSizeName?.width)! + 40, height: 35)
    }
    
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        //UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
        return UIEdgeInsetsMake(5, 20, 5, 20)
    }

    
    //返回HeadView的宽高
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: SCREEN_WITH, height: 35)
    }
    
    //返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
       
        var reusableview:LLCollectionHeadView?
        if kind == UICollectionElementKindSectionHeader{
            
        let   heaqView = (collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionViewHead", forIndexPath: indexPath) as? LLCollectionHeadView)!
            heaqView.titleLable.text = headViewArr[indexPath.section]
         reusableview = heaqView
        }
        return reusableview!
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(LLOurSeachNotication, object: hot_wordsArr[indexPath.row])
        
    }
 
 

}
