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
    
    var factDetails: FactDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialiveView()
        self.loadFactDetails()
    }

    func initialiveView() {
        view.backgroundColor = .white
        title = defaultHeaderTitle
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

// MARK:- UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factDetails?.facts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CustomCell {
            if let facts = factDetails?.facts, indexPath.row < facts.count {
                let fact = facts[indexPath.row]
                cell.updateCellContent(with: fact)
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK:- UITableViewDelegate methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let facts = factDetails?.facts, indexPath.row < facts.count {
            let fact = facts[indexPath.row]
            var isTitleAvailable = false
            if let str = fact.title, str.count > 0 {
                isTitleAvailable = true
            }
            
            var isDescriptionAvailable = false
            if let str = fact.description, str.count > 0 {
                isDescriptionAvailable = true
            }
            
            var isImageURLAvailable = false
            if let str = fact.imageHref, str.count > 0 {
                isImageURLAvailable = true
            }
            
            if !isTitleAvailable && !isDescriptionAvailable && !isImageURLAvailable {
                return 0.0
            }
            return UITableView.automaticDimension
        }
        return 0.0
    }
}


// MARK:- API services
extension ViewController {
    func loadFactDetails() {
        if let path = Bundle.main.path(forResource: "facts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let factDetails = try JSONDecoder().decode(FactDetails.self, from: data)
                self.factDetails = factDetails
                self.title = self.factDetails?.title
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
    }
}
