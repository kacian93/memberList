//
//  Table.swift
//  GngMember
//
//  Created by PC156 on 2022/09/08.
//

import UIKit

class Table: UIViewController {

    var tableView : UITableView!
    
    var csvMember = CSVLoad().loadCSV(filename: "GngsMember.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: .zero,style: .plain)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
    }
    
}
extension Table : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: TableCell.resId, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.csvMember.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableCell else {
            assert(false)
            return
        }
        
        let item = self.csvMember[indexPath.row]
        cell.display(item)
    }
    
}
