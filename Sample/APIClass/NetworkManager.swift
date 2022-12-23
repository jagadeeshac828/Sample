//
//  NetworkManager.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation

class NetworkManager {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadData<T: Decodable>(for: T.Type = T.self, from urlString: String) async throws -> T? {
        guard let url = URL(string: urlString) else {
            throw APIError.badURL
        }
        
        if let data = try await session.loadData(from: url) {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } else {
            throw APIError.dataEmpty
        }
        
    }
}
