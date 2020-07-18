//
//  CustomCell.swift
//  Wipro Assignment
//
//  Created by Dhiman Ranjit on 18/07/20.
//  Copyright © 2020 Dhiman Ranjit. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    let imageViewCustomCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    let labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupViews() {
        addSubview(imageViewCustomCell)
        addSubview(labelTitle)
        addSubview(labelDescription)
        
        imageViewCustomCell.anchorWithConstantsToTop(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 8.0, leftConstant: 8.0, bottomConstant: 0.0, rightConstant: 0.0)
        imageViewCustomCell.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageViewCustomCell.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelTitle.anchorWithConstantsToTop(topAnchor, left: imageViewCustomCell.rightAnchor, bottom: labelDescription.topAnchor, right: rightAnchor, topConstant: 8.0, leftConstant: 8.0, bottomConstant: 4.0, rightConstant: 8.0)
        labelTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 21.0).isActive = true
        
        labelDescription.anchorWithConstantsToTop(nil, left: labelTitle.leftAnchor, bottom: bottomAnchor, right: labelTitle.rightAnchor, topConstant: 0.0, leftConstant: 0.0, bottomConstant: 8.0, rightConstant: 0.0)
        labelDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 21.0).isActive = true
    }
}
