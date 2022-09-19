//MARK: -- 社員一覧の一つずつのセルを作るため
//
//  TableCellView.swift
//  GngMember
//
//  Created by PC156 on 2022/09/07.
//

import Foundation
import UIKit
import SwiftUI
class TableCell : UITableViewCell{
    
    
    //社員番号
    @IBOutlet var memberNumberLabel: UILabel!
    //名前
    @IBOutlet var nameLabel: UILabel!
    //職位
    @IBOutlet var positionLabel: UILabel!
    //所属
    @IBOutlet var affiliationLabel: UILabel!
    
    static let resId = "TableCell"
    
    @IBOutlet var view: UIView!
    
    //MARK: -- Default override
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: -- method
    //TableViewに登録するため
    static func register(to tableView : UITableView){
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: resId)
    }
    
    //セルに値の設定
    func display(_ member: Member)  {
        memberNumberLabel.text = member.employeeNumber
        nameLabel.text = member.kanjiName
        positionLabel.text = member.position
        affiliationLabel.text = member.affiliation
        
    }
    
}
