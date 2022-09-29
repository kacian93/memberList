//
//  DetailMemberView.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import UIKit
class DetailMemberView : UIViewController,UITableViewDelegate, UITableViewDataSource{
    var member : Member = Member(emloyeeNumber: "", kanjiName: "", kanaName: "", englishName: "", position: "", affiliation: "", email: "", tel: "")
    var detailTitle : [String]  = ["社員番号", "名前（漢字）","名前（カナ）","名前（英語）","性別","役職","所属","メール","電話番号","入社日"]
    var amember : [String] = []
    @IBOutlet var memberInfoTitleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    var cell : UITableViewCell = UITableViewCell()
    var xImage : UIImage = UIImage(systemName: "xmark")!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        backButton.setImage(xImage, for: .normal)
        amember.append(member.employeeNumber)
        amember.append(member.kanjiName)
        amember.append(member.kanaName)
        amember.append(member.englishName)
        amember.append(member.gender)
        amember.append(member.position)
        amember.append(member.affiliation)
        amember.append(member.email)
        amember.append(member.tel)
        amember.append(CSVLoad().fromDatetoString(date: member.dateOfEmployee))
        
        memberInfoTitleLabel.text = "社員情報"
        backButton.tintColor = .systemGray
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.backgroundColor = .systemGray5
        self.view.addSubview(view)
        view.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(memberInfoTitleLabel)
        tableView.backgroundColor = .systemGray5
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let label1 = cell.contentView.viewWithTag(1) as! UILabel
        let label2 = cell.contentView.viewWithTag(2) as! UILabel
        
        
        label1.text = detailTitle[indexPath.item]
        label2.text = amember[indexPath.item]
        
        cell.backgroundColor = UIColor.systemGray6
        cell.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        
    }
    @IBAction func clickBackButton(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
}
