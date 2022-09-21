//
//  GngsWebsiteController.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import WebKit

class GngsWebsiteController:UIViewController{
    @IBOutlet var gngsWebKit: WKWebView!
    
    //naviにあるボタン
    @IBOutlet var pageBackButton: UIButton!
    @IBOutlet var pageReloadButton: UIButton!
    @IBOutlet var pageForwardButton: UIButton!
    
    //ボタンに使うイメージ
    let backImage : UIImage = UIImage(systemName: "chevron.backward")!
    let forwardImage : UIImage  = UIImage(systemName: "chevron.forward")!
    let relaodImage : UIImage  = UIImage(systemName: "arrow.clockwise")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://gngs.co.jp/")
        let request = URLRequest(url: url!)
        gngsWebKit.load(request)
        
        pageBackButton.setImage(backImage, for: .normal)
        pageReloadButton.setImage(relaodImage, for: .normal)
        pageForwardButton.setImage(forwardImage, for: .normal)
        
        pageBackButton.tintColor =
        (gngsWebKit.canGoBack ? UIColor.blue : UIColor.gray)
        
        
        pageForwardButton.tintColor =
        (gngsWebKit.canGoForward ? UIColor.blue : UIColor.gray)
        
        gngsWebKit.navigationDelegate = self
    }
    
    @IBAction func pushReloadButton(_ sender: Any) {
        self.gngsWebKit.reload()
    }
    @IBAction func pushBackButton(_ sender: Any) {
        if self.gngsWebKit.canGoBack{
            self.gngsWebKit.goBack()
        }
    }
    @IBAction func pushForwardButton(_ sender: Any) {
        if self.gngsWebKit.canGoForward{
            self.gngsWebKit.goForward()
        }
    }
}

//MARK: --Delegate
extension GngsWebsiteController : WKNavigationDelegate{
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        
//            print("didStartProvisionalNavigation")
//            
//            pageBackButton.tintColor =
//            (gngsWebKit.canGoBack ? UIColor.blue : UIColor.gray)
//            
//            
//            pageForwardButton.tintColor =
//            (gngsWebKit.canGoForward ? UIColor.blue : UIColor.gray)
//
//    }
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print("didCommit")
//        
//        pageBackButton.tintColor =
//        (gngsWebKit.canGoBack ? UIColor.blue : UIColor.gray)
//        
//        
//        pageForwardButton.tintColor =
//        (gngsWebKit.canGoForward ? UIColor.blue : UIColor.gray)
//    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("didFinish")
        
        pageBackButton.tintColor =
        (gngsWebKit.canGoBack ? UIColor.blue : UIColor.gray)
        
        
        pageForwardButton.tintColor =
        (gngsWebKit.canGoForward ? UIColor.blue : UIColor.gray)
    }
}
