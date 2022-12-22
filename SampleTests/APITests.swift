//
//  APITests.swift
//  SampleTests
//
//  Created by Jagadeesha on 20/12/22.
//

import XCTest

final class APITests: XCTestCase {
    
    var mockSession: MockURLSession!

    override func setUpWithError() throws {
        mockSession = MockURLSession()
    }

    override func tearDownWithError() throws {
        mockSession = nil
    }

    func testSuccessCaseiTunesAPI() {
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
        Task {
            do {
                let result = try await manager.loadData(for: ITunesModel.self, from: "https://itunes.apple.com")
                XCTAssert(result?.resultCount == 50)
                exp.fulfill()
            } catch {
                
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testIfDataIsnil() {
        let manager = NetworkManager(session: mockSession)
        let exp = expectation(description: "Loading URL")
        Task {
            do {
                let result = try await manager.loadData(for: ITunesModel.self, from: "https://itunes.apple.com")
                exp.fulfill()
            } catch {
                
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testIfBadURLPassed() {
        var mockSession = MockURLSession()
        let manager = NetworkManager(session: mockSession)
        let exp = expectation(description: "Loading URL")
        Task {
            do {
                let result = try await manager.loadData(for: ITunesModel.self, from: "badURL")
            } catch {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}
