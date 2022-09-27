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
    @IBOutlet var naviView: UIView!
    @IBOutlet var outterview: UIView!
    @IBOutlet var pageBackButton: UIButton!
    @IBOutlet var pageReloadButton: UIButton!
    @IBOutlet var pageForwardButton: UIButton!
    
    var transitionDuration : Double = 0.2
    var transition : ScrollAnimation = .downScrolling
    
    //ボタンに使うイメージ
    let backImage : UIImage = UIImage(systemName: "chevron.backward")!
    let forwardImage : UIImage  = UIImage(systemName: "chevron.forward")!
    let relaodImage : UIImage  = UIImage(systemName: "arrow.clockwise")!
    private var scrollStartAt: CGFloat? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBarController?.tabBar.isHidden = true
//        gngsWebKit.frame = CGRect(x: 0, y: 0, width: outterview.bounds.width, height: outterview.bounds.height - (tabBarController?.tabBar.bounds.height ?? 0) * 2)
//        naviView.frame = CGRect(x: 0, y: gngsWebKit.bounds.height, width: gngsWebKit.bounds.width, height: tabBarController?.tabBar.bounds.height ?? 0)
        
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
        gngsWebKit.scrollView.delegate = self
//        let menuInteraction: UIContextMenuInteraction = UIContextMenuInteraction(delegate: self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.gngsWebKit.translatesAutoresizingMaskIntoConstraints  = false
        [
        self.gngsWebKit.topAnchor.constraint(equalTo: self.view.topAnchor),
        self.gngsWebKit.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        self.gngsWebKit.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        self.gngsWebKit.bottomAnchor.constraint(equalTo: self.naviView.bottomAnchor),
        ].forEach{ $0.isActive = true }
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
    
    func updateNaviTollbarPosition(isTabHidden flag:Bool) {
        let y: CGFloat = self.view.frame.maxY - self.naviView.frame.height - (flag ? 20 : (self.tabBarController?.tabBar.frame.height) ?? 0)
        
        self.naviView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.naviView.frame.height)
    }
}
enum ScrollAnimation{
    case upScrolling
    case downScrolling
}
//MARK: --Delegate
extension GngsWebsiteController : WKNavigationDelegate,UIScrollViewDelegate{
    

    
    
//    func webView(webView: WKWebView, shouldStartLoadWithRequest
//        request: NSURLRequest,
//                 navigationType: ) -> Bool {
//
//        if let scheme = request.url?.scheme {
//
//            if scheme.hasPrefix("http") || scheme.hasPrefix("https") {
//
//                //ページ内アンカー移動
//                let anchor = request.url?.absoluteString.components(separatedBy: "#")
//
//                if anchor?.count ?? 0 > 1 {
////                    self.webView.stringByEvaluatingJavaScript(from: "window.location.hash = \"\(anchor?.first)\"")
//
//                    pageBackButton.tintColor =
//                    (gngsWebKit.canGoBack ? UIColor.blue : UIColor.gray)
//
//
//                    pageForwardButton.tintColor =
//                    (gngsWebKit.canGoForward ? UIColor.blue : UIColor.gray)
//                }
//                return true
//
//            }
//        }
//        return false
//    }
    //UIContextMenuInteraction
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // move up
            
            self.scrollStartAt = scrollView.contentOffset.y
            
//            UIView.animate(withDuration: 0.5, animations: {
//                self.tabBarController?.tabBar.isHidden = true
//                self.naviView.frame = CGRect(x: 0, y: self.outterview.bounds.height - (self.tabBarController?.tabBar.bounds.height ?? 0) , width: self.gngsWebKit.bounds.width, height: 47)
//                self.gngsWebKit.frame = CGRect(x: 0, y: 0, width: self.outterview.bounds.width, height: self.outterview.bounds.height - (self.tabBarController?.tabBar.bounds.height ?? 0))
//
//            })
//        }
//        else if (self.lastContentOffset < scrollView.contentOffset.y) {
//           // move down
//            UIView.animate(withDuration: 0.5, animations: {
//                self.tabBarController?.tabBar.isHidden = false
//                self.naviView.frame = CGRect(x: 0, y: self.outterview.bounds.height - (self.tabBarController?.tabBar.bounds.height ?? 0) * 2  , width: self.gngsWebKit.bounds.width, height: 47)
//                self.gngsWebKit.frame = CGRect(x: 0, y: 0, width: self.outterview.bounds.width, height: self.outterview.bounds.height - (self.tabBarController?.tabBar.bounds.height ?? 0) * 2)
//
//            })
//        }
//
//        // update the new position acquired
//        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let prevY : CGFloat = self.scrollStartAt else {return}
        let currY = scrollView.contentOffset.y
        let scrollToUp = currY <= prevY
        
        if scrollToUp{
            self.tabBarController?.tabBar.isHidden  = false
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tabBarController?.tabBar.alpha = scrollToUp ? 1 : 0
            self.updateNaviTollbarPosition(isTabHidden: !scrollToUp)
        }, completion: { _ in
            self.tabBarController?.tabBar.isHidden = !scrollToUp
        })
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { 
        
        pageBackButton.tintColor =
        (gngsWebKit.canGoBack ? UIColor.blue : UIColor.gray)
        
        
        pageForwardButton.tintColor =
        (gngsWebKit.canGoForward ? UIColor.blue : UIColor.gray)
    }

}
//final class SingleScrollAndLongPressRecognizer : UIGestureRecognizer{
//    var startLocation : CGPoint = .zero
//    var distance : CGFloat  = .zero
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        if self.state == .possible{
//            self.startLocation = touches.first?.location(in: nil) ?? .zero
//            self.state = .began
//        }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
//        self.state = .cancelled
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
//        self.state = .changed
//        let location = touches.first?.location(in: nil) ?? .zero
//        let dx = startLocation.x - location.x
//        let dy  = startLocation.y - location.y
//        self.distance = sqrt(dx*dx + dy*dy)
//    }
//
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        self.state = .ended
//        self.startLocation = .zero
//        self.distance = .zero
//    }
//}
//
//
//class Coordinator : NSObject, UIGestureRecognizerDelegate{
//    var touchDownCallBack : (() -> Void)
//    var touchUpCallBack : (() -> Void)
//    var touchMoveCallBack : ((CGFloat) -> Void)
//
//    init(touchDownCallBack : @escaping (() -> Void) , touchUpInside : @escaping (() -> Void) , touchMoveCallBack : @escaping ((CGFloat) -> Void)) {
//        self.touchMoveCallBack = touchMoveCallBack
//        self.touchUpCallBack = touchUpInside
//        self.touchDownCallBack = touchDownCallBack
//    }
//}
