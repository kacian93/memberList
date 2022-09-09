//
//  JoinMemberPositionPicker.swift
//  GngMember
//
//  Created by PC156 on 2022/09/09.
//

import Foundation
import UIKit
import SwiftUI
class JoinMemberPositionPicker : UITableViewCell{

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var selectTextField: UITextField!
    @IBOutlet var button: UIButton!
    
    var selectimage = UIImage(systemName: "chevron.down")
    let position = ["平社員","主任","課長","部長","次長","代表"]
    var picker : UIPickerView = UIPickerView()
    
    static var pickerResId : String = "join_memeber_picker_view"
    
    
    static func register(to tableView : UITableView) {
        tableView.register(UINib(nibName: "JoinMemberPositionPickerView", bundle: nil), forCellReuseIdentifier: JoinMemberPositionPicker.pickerResId)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func display (title : String) {
        button.setImage(selectimage, for: .normal)
        
        picker.delegate = self
        picker.dataSource = self
        
        
        selectTextField.inputView = picker
        selectTextField.textAlignment = .center
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 80))
    
        titleLabel.text = title
        
        view.addSubview(titleLabel)
        
        self.addSubview(view)
    }
}
extension JoinMemberPositionPicker : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return position.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return position[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectTextField.text = position[row]
        selectTextField.resignFirstResponder()
    }
}
