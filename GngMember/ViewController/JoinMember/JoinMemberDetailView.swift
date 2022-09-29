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
    //ID（メールアドレス）
    @IBOutlet var idLabel: UILabel!
    //職業
    @IBOutlet var positionLabel: UILabel!
    //性別
    @IBOutlet var genderLabel: UILabel!
    //メールメガジン受信
    @IBOutlet var megazineLabel: UILabel!
    //約款同意
    @IBOutlet var agreementLabel: UILabel!
    //memo
    @IBOutlet var memoLabel: UILabel!
    //Backボタンのイメージ
    var backImage : UIImage = UIImage(systemName: "xmark")!
    
    var csvLoad : CSVLoad = CSVLoad()
    
    @IBOutlet var OKbutton: UIButton!
    var signupMember : Member = Member(emloyeeNumber: "", kanjiName: "", kanaName: "", englishName: "", position: "", affiliation: "", email: "", tel: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(backImage, for: .normal)
        
        idLabel.text = signupMember.email
        genderLabel.text = signupMember.gender
        megazineLabel.text = signupMember.receivedMagazine ? "許可" : "不可"
        positionLabel.text = signupMember.position
        agreementLabel.text = signupMember.agreement ? "同意" : "非同意"
        memoLabel.text = signupMember.memo.isEmpty ? "なし" : signupMember.memo
        
    }
    @IBAction func pushBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushOkButton(_ sender: Any) {
        
        let member : Member = Member(emloyeeNumber: "01-11111111", kanjiName: signupMember.kanjiName, kanaName: signupMember.kanaName, englishName: signupMember.englishName, gender: signupMember.gender, password: signupMember.password, position: signupMember.position, affiliation: "第１チーム", email: signupMember.email, tel: "defualt", dateOfEmployee: Date.now, receivedMagazine: signupMember.receivedMagazine)
        csvLoad.writeCsv(filename: "GngsMember", member: member)
        dismiss(animated: true)
    }
}
