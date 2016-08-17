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
    //模型
    var molde:LLChidrenModel?
    /// 底部数据
    var botoomView:LLDetailBootomView?
    
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
        
        
        botoomView = LLDetailBootomView(frame: CGRect(x:0 ,y: SCREEN_HEIGHT - 44,width: SCREEN_WITH,height: 44), block: { (button) in
            
        })
        view.addSubview(botoomView!)
      
        botoomView?.model = molde
        self.title = titleName
        view.addSubview(webView)
        
        webView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo((botoomView?.snp_top)!)
        }
             guard  let detaiString = detailUrl else {
        
            return
        }
        
        let url = NSURL(string:detaiString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)

       
       }
    
      // MARK: ---- 懒加载
    
    private lazy var webView:WKWebView = {
        
        let web = WKWebView()
        web.backgroundColor = UIColor.clearColor()
        web.UIDelegate = self
        web.navigationDelegate = self
        web.userInteractionEnabled = true

      //  web.UIDelegate = self
        
        return web
    
    }()
    
    

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
    /**
     WKWebView 点击链接无反应
     */
    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if (navigationAction.targetFrame?.mainFrame != true) {
            webView.loadRequest(navigationAction.request)
        }
        
        return nil
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.targetFrame == nil {
            
            print("跳转的是一个新页面")
            
            self.botoomView?.hidden = true
            webView.loadRequest(navigationAction.request)
        }else {
        self.botoomView?.hidden = false
        }
        
        decisionHandler(.Allow)
        
    }

}
