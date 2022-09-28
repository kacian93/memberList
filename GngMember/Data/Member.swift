//
//  Member.swift
//  GngsMember
//
//  Created by PC156 on 2022/09/03.
//

import Foundation

class Member : ObservableObject{
    var employeeNumber : String
    var kanjiName : String
    var kanaName : String
    var englishName : String
    var gender : String
    var password : String
    var position : String
    var affiliation : String
    var email : String
    var tel :  String
    var dateOfEmployee : Date
    var receivedMagazine : Bool
    
    init(emloyeeNumber:String, kanjiName: String, kanaName:String , englishName: String, gender : String = "male" , password : String = "", position : String, affiliation : String, email : String, tel : String, dateOfEmployee: Date = Date.now, receivedMagazine: Bool = true) {
        self.employeeNumber = emloyeeNumber
        self.kanjiName = kanjiName
        self.kanaName = kanaName
        self.englishName = englishName
        self.gender = gender
        self.password = password
        self.position = position
        self.affiliation = affiliation
        self.email = email
        self.tel = tel
        self.dateOfEmployee = dateOfEmployee
        self.receivedMagazine = receivedMagazine
    }
}
enum Position : String{
    case regular = "平社員"
    case chief = "主任"
    case sectionChief = "課長"
    case headOfDepartment = "部長"
    
}
enum Gender : String{
    case male = "男"
    case female = "女"
}
