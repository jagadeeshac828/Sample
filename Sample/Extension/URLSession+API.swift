//
//  URLSession+API.swift
//  Sample
//
//  Created by Jagadeesha on 22/12/22.
//

import Foundation
enum APIError: String, Error {
    case nonSuccessStatusCode = "nonSuccessStatusCode"
    case parsingError = "parsingError"
    case badURL = "badURL"
    case dataEmpty = "DataEmpty"
}

protocol NetworkSession {
    func loadData(from url: URL) async throws -> Data?
}

extension URLSession: NetworkSession {
    func loadData(from url: URL) async throws -> Data? {
        do {
            let (data, response) = try await data(from: url)
            guard let httpStausCode = (response as? HTTPURLResponse)?.statusCode,
                  (200...299).contains(httpStausCode) else {
                throw APIError.nonSuccessStatusCode
            }
            return data
        }
    }
}

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
         try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                 guard let data = data, let response = response else {
                     let error = error ?? URLError(.badServerResponse)
                     return continuation.resume(throwing: error)
                 }

                 continuation.resume(returning: (data, response))
             }

             task.resume()
        }
    }
}
