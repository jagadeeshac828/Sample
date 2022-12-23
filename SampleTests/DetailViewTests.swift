//
//  DetailViewTests.swift
//  SampleTests
//
//  Created by Jagadeesha on 22/12/22.
//

import XCTest

final class DetailViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlertIsPresented() {
        let viewController = UIApplication.shared.windows.first?.rootViewController
        let expectation = expectation(description: "shows alert")
        viewController?.alert(title: "Success", message: "Solution")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(UIApplication.shared.windows.first?.rootViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)
    }
    
}
