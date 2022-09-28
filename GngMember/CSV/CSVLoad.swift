//
//  CSVLoad.swift
//  GngsMember
//
//  Created by PC156 on 2022/09/03.
//

import Foundation
import SwiftUI
import WebKit
class CSVLoad{
    @Published var csvMemberArray : [Member] = []
    var csvStringArray : [String] = []
    
    
    /// CSVを読み込んで[Member]に入れる
    ///　①　CSVを読み込んで１ライン（\n基準で分ける）で[String]配列に一時的に保存
    ///　②　①番で宣言した[String]をコンマ基準で分けてMemberに入れる
    ///　③　②番のMemberを[Member]に追加
    /// - Parameter filename: ファイル名
    /// - Returns: ③番まで終わった[Member]
    func loadCSV(filename : String) -> [Member]{
        //        let csvBundle = Bundle.main.path(forResource: filename, ofType: "csv")!
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            fatalError("フォルダURL取得エラー")
        }
        
        let fileURL = dirURL.appendingPathComponent("GngsMember.csv")
        
        do{
            let csvData  = try String(contentsOf: fileURL)
            //            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvStringArray = lineChange.components(separatedBy: "\n")
            //            csvStringArray.removeLast()
            //
            for _ in csvStringArray{
                let parts = lineChange.components(separatedBy: ",")
                let member : Member =  Member(emloyeeNumber: parts[0], kanjiName: parts[1], kanaName: parts[2], englishName: parts[3], gender: parts[5], password: parts[8], position: parts[4],  affiliation: parts[6], email: parts[7],
                                              tel : parts[9],
                                              dateOfEmployee:  fromStringToDate(date: parts[10]))
                csvMemberArray.append(member)
                
            }
            
        }catch{
            print("csv error")
        }
        return csvMemberArray
    }
    
    
    func writeCsv(filename: String, member: Member) -> Void  {
        guard var url = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return } // 検索するだけなので、createはfalse
        
        url = url.appendingPathComponent("GngsMember.csv")
        print("url \(url)")
        
        do {
            print("FileManager.default.fileExists \(FileManager.default.fileExists(atPath: url.absoluteString))")
            if FileManager.default.fileExists(atPath: url.absoluteString) {
                
                var csvString : String = ""
                let csvData  = try String(contentsOf: url)
                print("csvData \(csvData)")
                
                
                let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
                csvStringArray = lineChange.components(separatedBy: "\n")
                
                for item in csvStringArray {
                    csvString += item
                }
                
                let memberInfomation = ("\(member.employeeNumber),\(member.kanjiName),\(member.kanaName),\(member.englishName),\(member.gender),\(member.password),\(member.position),\(member.affiliation),\(member.email),\(member.tel),\(fromDatetoString(date: member.dateOfEmployee))\n")
                
                csvString.append(contentsOf: memberInfomation)
                
                print("csvString : \(csvString)")
                try csvString.write(to: url, atomically: true, encoding: .utf8)
                
            }
            
        } catch {
            print("failed to write: \(error)")
        }
    }
    /// 入社日がDate形式なのでStringをDate軽視に変わる関数
    /// - Parameter date:　入社日のStringタイプ（CSVファイルがString）
    /// - Returns:クラスのMemberの入社日はDateなのでDate
    func fromStringToDate(date:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: date) ?? Date()
    }
    
    
    ///　Date形をStringタイプで変換する関数
    /// - Parameter date: Date（Memberの入社日）
    /// - Returns: String
    func fromDatetoString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: date)
    }
    
    
    
    //CSVファイル保存メソッド
    //    func saveCSV() {
    //
    //        //改行区切りで部活配列を連結する。
    //        let outputStr = dataList.joinWithSeparator("\n")
    //
    //        do {
    //            if(outputStr == "") {
    //                //部活配列が空の場合はユーザーが保存したCSVファイルを削除する。
    //                try fileManager.removeItemAtPath(userPath)
    //            } else {
    //                //ファイルを出力する。
    //                try outputStr.writeToFile(userPath, atomically: false, encoding: NSUTF8StringEncoding )
    //            }
    //        } catch {
    //            print(error)
    //        }
    //    }
}
