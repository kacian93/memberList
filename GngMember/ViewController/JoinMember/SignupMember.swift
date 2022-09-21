//
//  SignupMember.swift
//  GngMember
//
//  Created by PC156 on 2022/09/13.
//

import Foundation
struct SignupMember{
    //ID（メールアドレス）
    var id : String = ""
    var password : String = ""
    //性別
    var gender : Gender = .male
    //約款同意
    var agreement : Bool = true
    //メール受信
    var megazine : Bool = true
    //メモ
    var memo : String = ""
    //職業
    var position : String = ""
}
