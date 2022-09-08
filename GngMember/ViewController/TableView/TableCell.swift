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
    static let resId = "TableCell"
    
    @IBOutlet var view: UIView!
    static func register(to tableView : UITableView){
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: resId)
    }
    
    func display(_ member: Member)  {
        print("display : \(member.employeeNumber)")
        memberNumberLabel.text = member.employeeNumber
    }
    
}
