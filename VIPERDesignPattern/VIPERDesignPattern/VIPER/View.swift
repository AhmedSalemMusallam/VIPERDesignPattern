//
//  View.swift
//  VIPERDesignPattern
//
//  Created by Ahmed Salem on 06/04/2023.
//

import Foundation
import UIKit
//viewController
//protocol
//reference to presenter

protocol AnyView{
    var presenter: AnyPresenter? { get set }
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController:UIViewController, AnyView
{
    //Mark:- variables
    var presenter: AnyPresenter?
    private let tabeleView : UITableView={
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(label)
        view.addSubview(tabeleView)
        
        tabeleView.delegate = self
        tabeleView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabeleView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tabeleView.reloadData()
            self.tabeleView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.tabeleView.isHidden = true
            self.label.text = error
            self.label.isHidden = false
        }
    }
    
}

//Mark:- extersion for table view delegation and datasource
extension UserViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    
}
