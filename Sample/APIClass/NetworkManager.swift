//
//  NetworkManager.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation

enum NetworkError: String, Error {
    case noDataorError
    case badURL
    case dataEmpty
}

class NetworkManager {
    private let session: NetworkSession
    
    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadData<T: Decodable>(for: T.Type = T.self, from urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.badURL))
            return
        }
        session.loadData(from: url) { data, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(NetworkError.noDataorError))
                }
            } else {
                completionHandler(.failure(NetworkError.dataEmpty))
            }
        }
    }
}
