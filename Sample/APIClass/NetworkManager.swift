//
//  NetworkManager.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation

class NetworkManager {
    private let session: NetworkSession
    
    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
        
    }
    
    func loadData<T: Decodable>(for: T.Type = T.self, from urlString: String) async throws -> T? {
        guard let url = URL(string: urlString) else {
            throw APIError.badURL
        }
        do {
            if let data = try await session.loadData(from: url) {
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    return model
                } catch {
                    throw APIError.parsingError
                }
            } else {
               return nil
            }
        } catch {
            throw error
        }
        
    }
}
