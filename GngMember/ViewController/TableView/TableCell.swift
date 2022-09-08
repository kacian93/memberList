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
    
    
    
    @IBOutlet var memberNumberLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var affiliationLabel: UILabel!
    static let resId = "TableCell"
    
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func register(to tableView : UITableView){
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: resId)
    }
    
    func display(_ member: Member)  {
        memberNumberLabel.text = member.employeeNumber
        nameLabel.text = member.kanjiName
        positionLabel.text = member.position
        affiliationLabel.text = member.affiliation
        
    }
    
}
