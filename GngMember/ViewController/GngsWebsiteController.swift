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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://gngs.co.jp/")
        let request = URLRequest(url: url!)
        gngsWebKit.load(request)
    }
}
