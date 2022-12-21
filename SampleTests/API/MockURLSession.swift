//
//  MockURLSession.swift
//  SampleTests
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation
class MockURLSession:URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?)  -> Void
    var data: Data?
    var error: Error?
    override func dataTask(with url: URL,completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
