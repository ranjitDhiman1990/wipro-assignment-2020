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
    
    var refreshControl = UIRefreshControl()
    var loaderView = CustomLoaderView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
    
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
        setupActivityIndicatorView()
        
        view.addSubview(tableView)
        tableView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        registerCells()
    }
    
    func registerCells() {
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(loaderView)
        setupActivityIndicatorViewConstraints()
    }

    private func setupActivityIndicatorViewConstraints() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        self.loadFactDetails()
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
                cell.imageViewCustomCell.rounded()
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
        self.loaderView.startAnimating()
        APIServices.shared.getFactDetails { [weak self] (response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.loaderView.stopAnimating()
            }
            
            switch(response) {
            case .success(let factDetails):
                self.factDetails = factDetails
                DispatchQueue.main.async {
                    self.title = factDetails.title
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWithSingleButton(title: nil, message: error.message, okButtonText: "OK", okButtonAction: nil)
                }
                break
            }
        }
    }
}
