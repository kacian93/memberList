//
//  JoinMember.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import UIKit
class JoinMemberController : UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
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
        
        
        JoinMemberDefaultRow.register(to: tableView)
        JoinMemberPositionPicker.register(to: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
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
extension JoinMemberController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0,1,2:
            return
            tableView.dequeueReusableCell(withIdentifier: JoinMemberDefaultRow.joinMemberResId, for: indexPath)
            
//        case 3:
//            return tableView.dequeueReusableCell(withIdentifier: JoinMemberPositionPicker.pickerResId, for: indexPath)
        default :
            return tableView.dequeueReusableCell(withIdentifier: JoinMemberDefaultRow.joinMemberResId, for: indexPath)
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
