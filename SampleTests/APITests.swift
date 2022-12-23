//
//  APITests.swift
//  SampleTests
//
//  Created by Jagadeesha on 20/12/22.
//

import XCTest

final class APITests: XCTestCase {
    
    var mockSession: MockURLSession?
    var manager: NetworkManager?

    override func setUpWithError() throws {
        mockSession = MockURLSession()
        if let mockSession = mockSession {
            manager = NetworkManager(session: mockSession)
        }
    }

    override func tearDownWithError() throws {
        mockSession = nil
        manager = nil
    }

    func testSuccessCaseiTunesAPI() {
        if let path = Bundle(for: type(of: self)).path(forResource: "iTunes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                mockSession?.data = data
            } catch {
                // handle error
            }
        }
        let exp = expectation(description: "Loading URL")
        Task {
            do {
                if let result = try await manager?.loadData(for: ITunesModel.self, from: "https://itunes.apple.com") {
                    print(result)
                    XCTAssert(result.resultCount == 50)
                }
                exp.fulfill()
            } catch {
                
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testIfDataIsnil() {
        let exp = expectation(description: "Loading URL")
        Task {
            do {
                _ = try await manager?.loadData(for: ITunesModel.self, from: "https://itunes.apple.com")
            } catch {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
}
