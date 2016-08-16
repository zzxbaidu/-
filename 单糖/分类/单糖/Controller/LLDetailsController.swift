//
//  LLDetailsController.swift
//  单糖
//
//  Created by JYD on 16/8/16.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class LLDetailsController: UIViewController {

    /// 详情页标题
    var titleName: String?
    
    var detailUrl:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = UIColor.whiteColor()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 添加 UI 视图
    
    private func setupUI() {
        
        self.title = titleName
        view.addSubview(webView)
             guard  let detaiString = detailUrl else {
        
            return
        }
        
        let url = NSURL(string:detaiString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)

    
       }
    
      // MARK: ---- 懒加载
    
    private lazy var webView:WKWebView = {
        
        let web = WKWebView(frame: self.view.bounds)
        web.backgroundColor = UIColor.clearColor()
        web.UIDelegate = self
        web.navigationDelegate = self
        web.userInteractionEnabled = true

      //  web.UIDelegate = self
        
        return web
    
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LLDetailsController:WKUIDelegate ,WKNavigationDelegate {
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.showWithStatus("拼命加载中...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.showErrorWithStatus("加载失败....")
    }

}
