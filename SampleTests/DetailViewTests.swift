//
//  DetailViewTests.swift
//  SampleTests
//
//  Created by Jagadeesha on 22/12/22.
//

import XCTest

final class DetailViewTests: XCTestCase {
    var viewController: UIViewController?
    override func setUpWithError() throws {
        viewController = UIApplication.shared.windows.first?.rootViewController
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testAlertIsPresented() {
        let expectation = expectation(description: "shows alert")
        viewController?.alert(title: "Success", message: "Solution")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(self.viewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)
    }
    
}
