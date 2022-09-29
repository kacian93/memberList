//
//  LoginController.swift
//  GngMember
//
//  Created by PC156 on 2022/09/29.
//

import Foundation
import UIKit

class LoginController : UIViewController{
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var forgetPassword: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func errorMessage(message: String){
        
    }
    
    @IBAction func pushLoginButton(_ sender: Any) {
        let userid : String? = idTextField.text
        let userpassword: String? = passwordTextField.text
        
        let csvData = CSVLoad().loadCSV(filename: "GngsMember.csv")
        if csvData.count == 0{
            if userid == "park", userpassword == "park"{
                performSegue(withIdentifier: "passLogin", sender: nil)
            }
        }else{
        
            for member in csvData {
                if userid == member.email{
                    if userpassword == member.password{
                        performSegue(withIdentifier: "passLogin", sender: nil)
                    }else{
                        errorMessage(message : "パスワードが一致しません。")
                    }
                }else{
                    errorMessage(message: "IDが存在しません。ご確認お願いします")
                }
            }
        }
    }
}
