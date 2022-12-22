//
//  MockURLSession.swift
//  SampleTests
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation
class MockURLSession: NetworkSession {
    var data: Data?
    var error: Error?
    
    func loadData(from url: URL) async throws -> Data? {
        if let error = error {
            throw error
        }
        return data
    }
}
