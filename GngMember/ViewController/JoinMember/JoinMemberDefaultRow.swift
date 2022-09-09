//
//  JoinMemberDefaultRow.swift
//  GngMember
//
//  Created by PC156 on 2022/09/09.
//

import Foundation
import UIKit
class JoinMemberDefaultRow : UITableViewCell{
    static var joinMemberResId : String = "join_member_default_row"
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    
    static func register(to tableview: UITableView) {
        tableview.register(UINib(nibName: "JoinMemberDefaultRowView", bundle: nil), forCellReuseIdentifier: JoinMemberDefaultRow.joinMemberResId)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func display(title : String, content : String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 80))
    
        titleLabel.text = title
        contentTextField.placeholder = content
        
        view.addSubview(titleLabel)
        view.addSubview(contentTextField)
        
        self.addSubview(view)
    }
}
