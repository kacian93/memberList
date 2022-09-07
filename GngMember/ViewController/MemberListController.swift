//
//  ViewController.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import UIKit

class MemberListController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var csvMember : [Member] = CSVLoad().loadCSV(filename: "GngsMember")
    
    @IBOutlet var tableTitle: UITableViewCell!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var defaultCell: UITableViewCell!
    
    @IBOutlet var memberListTitle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.backgroundColor = UIColor.lightGray
        
        let number = UILabel(frame: CGRect(x: 10 + view.frame.size.width / 16, y: 0, width: view.frame.size.width/8 * 3, height: 40))
        number.text = "社員番号"
        
        let name = UILabel(frame: CGRect(x: view.frame.size.width/8 * 3, y: 0, width: view.frame.size.width/8, height: 40))
        name.text = "名前"
        let position = UILabel(frame: CGRect(x: view.frame.size.width/16 * 9, y: 0, width: view.frame.size.width/4, height: 40))
        position.text = "役職"
        let affiliation = UILabel(frame: CGRect(x: view.frame.size.width/16 * 13 + 5, y: 0, width: view.frame.size.width/4, height: 40))
        affiliation.text = "所属"
        
        memberListTitle.addSubview(number)
        memberListTitle.addSubview(name)
        memberListTitle.addSubview(position)
        memberListTitle.addSubview(affiliation)
        memberListTitle.backgroundColor = UIColor.tertiaryLabel
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        let number = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.size.width/8 *
                                           3, height: 40))
        
        let name = UILabel(frame: CGRect(x: view.frame.size.width/8 * 3, y: 0, width: view.frame.size.width/8, height: 40))
        let position = UILabel(frame: CGRect(x: view.frame.size.width/16 * 9 - 5, y: 0, width: view.frame.size.width/4, height: 40))
        let affiliation = UILabel(frame: CGRect(x: view.frame.size.width/16 * 12 + 10, y: 0, width: view.frame.size.width/4, height: 40))
        
        
        
        number.text = csvMember[indexPath.item].employeeNumber
        name.text = csvMember[indexPath.item].kanjiName
        position.text = csvMember[indexPath.item].position
        affiliation.text = csvMember[indexPath.item].affiliation
        
        
        
        cell.addSubview(number)
        cell.addSubview(name)
        cell.addSubview(position)
        cell.addSubview(affiliation)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailMember", sender: nil)
    }
    
    
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
