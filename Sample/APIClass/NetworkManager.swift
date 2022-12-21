//
//  NetworkManager.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation

enum NetworkError: Error {
    case noDataorError
    case badURL
}

class NetworkManager {
    private let session: URLSession

    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadData<T: Decodable>(for: T.Type = T.self, from urlString: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                completionHandler(.failure(.noDataorError))
            }
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(.noDataorError))
                }
            }
        }

        task.resume()
    }
}
