//
//  JoinMemberDetailView.swift
//  GngMember
//
//  Created by PC156 on 2022/09/13.
//

import Foundation
import UIKit
class JoinMemberDetailView: UIViewController{
    @IBOutlet var backButton: UIButton!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var megazineLabel: UILabel!
    @IBOutlet var agreementLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    var backImage : UIImage = UIImage(systemName: "xmark")!
    var signupMember : SignupMember = SignupMember()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(backImage, for: .normal)
        
        idLabel.text = signupMember.id
        genderLabel.text = signupMember.gender.rawValue
        megazineLabel.text = signupMember.megazine ? "許可" : "不可"
        positionLabel.text = signupMember.position
        agreementLabel.text = signupMember.agreement ? "同意" : "非同意"
        memoLabel.text = signupMember.memo.isEmpty ? "なし" : signupMember.memo
    }
    @IBAction func pushBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
