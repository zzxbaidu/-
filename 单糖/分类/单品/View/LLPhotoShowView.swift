//
//  LLPhotoShowView.swift
//  单糖
//
//  Created by JYD on 16/8/19.
//  Copyright © 2016年 周尊贤. All rights reserved.
//





import UIKit
import WebKit
import SVProgressHUD
class LLPhotoShowView: UIView {

   
     init(frame: CGRect, urlStr:String) {
        super.init(frame: frame)
        
     
        addSubview(webView)
        webView.frame = bounds
        
        let url = NSURL(string:urlStr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ---- 懒加载
    
     lazy var webView:UIWebView = {
        
        let web = UIWebView()
       
        web.backgroundColor = UIColor.clearColor()
        web.delegate = self
        web.userInteractionEnabled = true
        return web
        
    }()


}

extension LLPhotoShowView: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
       SVProgressHUD.showWithStatus("拼命加载中...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
         SVProgressHUD.showErrorWithStatus("加载失败....")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.URL)
        
        
        return true
    }
}


//extension LLPhotoShowView:WKUIDelegate ,WKNavigationDelegate {
//    
//    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        SVProgressHUD.showWithStatus("拼命加载中...")
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//    }
//    
//    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
//        SVProgressHUD.dismiss()
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        
//    }
//    
//    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
//        SVProgressHUD.showErrorWithStatus("加载失败....")
//    }
//    /**
//     WKWebView 点击链接无反应
//     */
//    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        
//        if (navigationAction.targetFrame?.mainFrame != true) {
//            webView.loadRequest(navigationAction.request)
//        }
//        
//        return nil
//    }
//    
//    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
//        
//        if navigationAction.targetFrame == nil {
//            
//            print("跳转的是一个新页面")
//            
//         
//            webView.loadRequest(navigationAction.request)
//        }else {
//            
//        }
//        
//        decisionHandler(.Allow)
//       decisionHandler(.Cancel)
//    }
//    
//}

