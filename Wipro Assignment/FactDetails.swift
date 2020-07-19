//
//  FactDetails.swift
//  Wipro Assignment
//
//  Created by Dhiman Ranjit on 19/07/20.
//  Copyright © 2020 Dhiman Ranjit. All rights reserved.
//

import Foundation

struct FactDetails: Codable {
    var title: String?
    var facts: [FactAbout]?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case facts = "rows"
    }
}

struct FactAbout: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
