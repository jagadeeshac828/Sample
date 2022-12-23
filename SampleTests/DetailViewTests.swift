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
    
    func testCheckConstructData() {
        var viewModel = DetailViewModel()
        if let path = Bundle(for: type(of: self)).path(forResource: "iTunes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try JSONDecoder().decode(ITunesModel.self, from: data)
                if let result = model.results?[0] {
                   let value = viewModel.constructDataForLabel(result)
                   let output =
                    """
                    Track Name - Upside Down
                    Artist Name - Jack Johnson
                    """
                   XCTAssertEqual(value, output)
                }
                
            } catch {
                // handle error
            }
        }
    }
    
}
