//
//  Wipro_AssignmentTests.swift
//  Wipro AssignmentTests
//
//  Created by Dhiman Ranjit on 20/07/20.
//  Copyright © 2020 Dhiman Ranjit. All rights reserved.
//

import XCTest
@testable import Wipro_Assignment

class Wipro_AssignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFactModel() throws {
        let fact = FactAbout(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        XCTAssert(fact.title == "Beavers")
        XCTAssert(fact.imageHref == "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    }
    
    func testFactDetailsModel() throws {
        let factDetails = FactDetails(title: "About India", facts: [FactAbout(title: "Beavers", description: nil, imageHref: nil)])
        XCTAssert(factDetails.title == "About India")
        XCTAssert(factDetails.facts?.count == 1)
    }
}
