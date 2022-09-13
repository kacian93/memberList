//
//  Notification.swift
//  GngMember
//
//  Created by PC156 on 2022/09/11.
//

import Foundation
import UIKit
extension Notification{
    var keyboardHeight : CGFloat? {
        return (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
}
