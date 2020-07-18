//
//  ViewController.swift
//  Wipro Assignment
//
//  Created by Dhiman Ranjit on 18/07/20.
//  Copyright © 2020 Dhiman Ranjit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellID = "cellID"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialiveView()
    }

    func initialiveView() {
        view.backgroundColor = .white
        title = "Home"
        view.addSubview(tableView)
        tableView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        registerCells()
    }
    
    func registerCells() {
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: cellID)
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CustomCell {
            cell.labelTitle.text = "Title"
            cell.labelDescription.text = "Description Text\nDescription Text\nDescription Text\nDescription Text\nweqwrwqe"
            cell.imageViewCustomCell.rounded()
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
}
