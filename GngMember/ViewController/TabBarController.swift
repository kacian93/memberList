//
//  ViewController.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import UIKit
class TabBarController : UIViewController, UITabBarDelegate{
    
    @IBOutlet var myTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTabBar = UITabBar()
        myTabBar.frame = CGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50)
        myTabBar.barTintColor = .tertiaryLabel
        myTabBar.tintColor = .white

        let memberlist : UITabBarItem = UITabBarItem(title: "社員一覧", image: .none, selectedImage: .none)
        memberlist.tag = 1
        let addMember : UITabBarItem = UITabBarItem(title: "入力画面", image: .none, selectedImage: .none)
        addMember.tag = 2
        let webkit : UITabBarItem = UITabBarItem(title: "webkit", image: .none, selectedImage: .none)
        webkit.tag = 3
        myTabBar.items = [memberlist,addMember,webkit]
        myTabBar.delegate = self

        self.view.addSubview(myTabBar)
    }

    func tabar(_ tabbar: UITabBar, didselect item: UITabBarItem){
        switch item.tag{
        case 1:
            print(1)

            let storyboard : UIStoryboard = self.storyboard!
            let memberlistView = storyboard.instantiateViewController(withIdentifier: "memberList")
            memberlistView.modalPresentationStyle = .fullScreen
                present(memberlistView, animated: true)
        case 2:
            print(2)
        default :
            return
        }
    }

}
