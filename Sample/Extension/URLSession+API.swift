//
//  URLSession+API.swift
//  Sample
//
//  Created by Jagadeesha on 22/12/22.
//

import Foundation
protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }

        task.resume()
    }
}
