//
//  APITests.swift
//  SampleTests
//
//  Created by Jagadeesha on 20/12/22.
//

import XCTest

final class APITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testSuccessCaseiTunesAPI() {
        let mockSession = MockURLSession()
        let manager = NetworkManager(session: mockSession)
        if let path = Bundle(for: type(of: self)).path(forResource: "iTunes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                mockSession.data = data
            } catch {
                // handle error
            }
        }
        let exp = expectation(description: "Loading URL")
        manager.loadData(for: ITunesModel.self, from: NetworkProvider.baseUrl) { result in
            switch result {
            case .success(let data):
                XCTAssert(data.resultCount == 50)
                exp.fulfill()
            case .failure(_):
                break
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFailureCase1iTunesAPI(){
        let mockSession = MockURLSession()
        let manager = NetworkManager(session: mockSession)
        let exp = expectation(description: "Loading URL")
        manager.loadData(for: ITunesModel.self, from: NetworkProvider.baseUrl) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
