//MARK: --社員一覧の表示のため。
//
//  ViewController.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import UIKit

class MemberListController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    //MARK: --変数
    //CSVファイルを読んで配列に入れいる
    var csvMember : [Member] = CSVLoad().loadCSV(filename: "GngsMember")
    @IBOutlet var tableTitle: UITableViewCell!
    
    //社員一覧のTableView
    @IBOutlet var tableView: UITableView!
    //社員番号
    @IBOutlet var number: UILabel!
    //社員名前
    @IBOutlet var name: UILabel!
    //職位
    @IBOutlet var position: UILabel!
    //所属
    @IBOutlet var affiliation: UILabel!
    
    //タイトル
    @IBOutlet var memberListTitle: UIView!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        //TableCell.xibを登録
        TableCell.register(to: tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        titlelabel()
        
    }
    
    //社員一覧のタイトル設定
    func titlelabel(){
        number.text = "社員番号"
        name.text = "名前"
        position.text = "役職"
        affiliation.text = "所属"
        
        memberListTitle.backgroundColor = UIColor.quaternaryLabel
    }
    
    //MARK: --delegate, datasource
    //tableViewのCell数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvMember.count
    }

    
    //特定(indexPath)なCellを作る。Datasourceに渡す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.dequeueReusableCell(withIdentifier: TableCell.resId, for: indexPath)
//
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
//        let number = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.size.width/8 *
//                                           3, height: 40))
//
//        let name = UILabel(frame: CGRect(x: view.frame.size.width/8 * 3, y: 0, width: view.frame.size.width/8, height: 40))
//        let position = UILabel(frame: CGRect(x: view.frame.size.width/16 * 9 - 5, y: 0, width: view.frame.size.width/4, height: 40))
//        let affiliation = UILabel(frame: CGRect(x: view.frame.size.width/16 * 12 + 10, y: 0, width: view.frame.size.width/4, height: 40))
//
//
//
//        number.text = csvMember[indexPath.item].employeeNumber
//        name.text = csvMember[indexPath.item].kanjiName
//        position.text = csvMember[indexPath.item].position
//        affiliation.text = csvMember[indexPath.item].affiliation
//
//
//
//        cell.addSubview(number)
//        cell.addSubview(name)
//        cell.addSubview(position)
//        cell.addSubview(affiliation)
//
//        return cell
//
    }

    //cellを表示。delegateに渡す
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableCell else {
            assert(false)
            return
        }

        let member = csvMember[indexPath.row]
        cell.display(member)
    }
    
    //cellを選択してとき、Segueを動く
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailMember", sender: nil)
    }
    
    //segueの設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailMember" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailMemberView else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                
                destination.member = csvMember[indexPath.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
