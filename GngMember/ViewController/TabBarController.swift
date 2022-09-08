//
//  ViewController.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//
import Foundation
import UIKit
class TabBarController : UITabBarController{
    
    @IBOutlet var myTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .lightGray
        
        appearance.stackedItemWidth = view.frame.width/3
    
        
        myTabBar.standardAppearance = appearance
        myTabBar.scrollEdgeAppearance = appearance
    
        myTabBar.tintColor = .white
//        myTabBar = UITabBar()
//        myTabBar.frame = CGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50)
//        myTabBar.barTintColor = .tertiaryLabel
//        myTabBar.tintColor = .white
//
//        let memberlist = MemberListController()
//        memberlist.tabBarItem = UITabBarItem(title: "社員一覧", image: .none, selectedImage: .none)
//        memberlist.tabBarItem.tag = 1
//        
//        let addMember = JoinMemberController()
//        addMember.tabBarItem = UITabBarItem(title: "入力画面", image: .none, selectedImage: .none)
//        addMember.tabBarItem.tag = 2
//        
//        let webkit = GngsWebsiteController()
//        webkit.tabBarItem = UITabBarItem(title: "webkit", image: .none, selectedImage: .none)
//        webkit.tabBarItem.tag = 3
//        
//        myTabBar.setItems([memberlist.tabBarItem, addMember.tabBarItem, webkit.tabBarItem], animated: true)
//        myTabBar.delegate = self
//        viewControllers = [memberlist, addMember, webkit]
//        
//        
//        self.view.addSubview(myTabBar)
//        self.myTabBar.delegate = self
//        
    }
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//            switch item.tag{
//            case 1:
//                print(1)
//
//                let storyboard : UIStoryboard = self.storyboard!
//                let memberlistView = storyboard.instantiateViewController(withIdentifier: "MemberListController")
//                memberlistView.modalPresentationStyle = .fullScreen
//                self.present(memberlistView, animated: true)
//            case 2:
//                print(2)
//            default :
//                return
//            }
//        }

}
