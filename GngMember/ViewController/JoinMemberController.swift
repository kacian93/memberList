//
//  JoinMember.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import UIKit
class JoinMemberController : UIViewController{
    var member : Member = Member(emloyeeNumber: "", kanjiName: "", kanaName: "", englishName: "", position: "", affiliation: "", email: "", tel: "", dateOfEmployee: Date.now)
    
    @IBOutlet var magazineSwitch: UISwitch!
    
    @IBOutlet var genderTitle: UILabel!
    @IBOutlet var femaleLabel: UILabel!
    @IBOutlet var maleLabel: UILabel!
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var maleButton: UIButton!
    let circle = UIImage(systemName: "circle")
    let selectedCircle = UIImage(systemName:  "circle.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderTitle.text  = "性別"
        maleLabel.text = "男"
        femaleLabel.text = "女"
        
        maleButton.isSelected = true
        femaleButton.isSelected = false
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
        
    }
    
    @IBAction func changeSwitch(_ sender: Any) {
        if magazineSwitch.isOn{
            member.receivedMagazine = true
        }
    }
    @IBAction func pushmaleButton(_ sender: UIButton) {
        maleButton.isSelected = true
        femaleButton.isSelected = false
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
        
        
    }
    @IBAction func pushFemaleButton(_ sender: UIButton) {
        maleButton.isSelected = false
        femaleButton.isSelected = true
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
        
    }
}
