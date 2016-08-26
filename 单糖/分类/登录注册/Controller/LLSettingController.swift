//
//  LLSettingController.swift
//  单糖
//
//  Created by JYD on 16/8/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLSettingController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.hidden = false
        
        self.title = "更多"
      
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(LLSettingCell.self, forCellReuseIdentifier: "LLSettingController")
        
        tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
          // MARK: ---- 懒加载
    
    
    private lazy var iconImageArr = ["more_icon_share_21x21_","more_icon_score_21x21_","more_icon_feedback_21x21_","checkUserType_icon_identity_21x21_","more_icon_notification_21x21_","more_icon_notification_21x21_","more_icon_about_21x21_"]
    
    
    private lazy var titleName = ["邀请好友使用单糖","给我们评分","意见反馈","我的身份","接收消息提醒","清除缓存","关于单糖"]

}


extension LLSettingController {
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }

     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:

        return 3

        case 1:
            
        return 3
       
        case 2:
            
        return 1
           
        default:
        return 0
        }
       
    
    }
    
 
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LLSettingController", forIndexPath: indexPath) as!LLSettingCell
        
        
        switch indexPath.section {
        case 0:
        cell.iconImage.image = UIImage(named: iconImageArr[indexPath.row])
          cell.titileLable.text = titleName[indexPath.row]
            if indexPath.row == 2 {
                
                cell.accessoryType = .DisclosureIndicator

            }
            
            break
            
        case 1:
            
            if indexPath.row == 0 {
                
                cell.accessoryType = .DisclosureIndicator
                cell.iconImage.image = UIImage(named: iconImageArr[3])
                
                cell.titileLable.text = titleName[3]
                let lable = UILabel()
                lable.textColor = UIColor.darkGrayColor()
                lable.text = "男孩 资审工作党"
              cell.contentView.addSubview(lable)
                lable.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(cell.contentView).offset(-12)
                    make.centerY.equalTo(cell.contentView)
                    })

                
            }else if indexPath.row == 1 {
                cell.iconImage.image = UIImage(named: iconImageArr[4])
                
                cell.titileLable.text = titleName[4]
                let switchButton = UISwitch()
                switchButton.on = true
            cell.contentView.addSubview(switchButton)
                switchButton.snp_makeConstraints(closure: { (make) in
                        make.right.equalTo(cell.contentView).offset(-12)
                                make.centerY.equalTo(cell.contentView)
                            })
            }else if indexPath.row == 2 {
            
                cell.iconImage.image = UIImage(named: iconImageArr[5])
                
                cell.titileLable.text = titleName[5]
            }
            
            
            break
        case 2:
            
            cell.iconImage.image = UIImage(named: iconImageArr[6])
            
            cell.titileLable.text = titleName[6]
            
            break
            
        default:
            break
        }
        

        return cell
    
    
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 30))
        view.backgroundColor = LLColor(220, g: 220, b: 220, a: 1.0)
        
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


}
