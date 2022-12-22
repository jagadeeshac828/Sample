//
//  ListViewModel.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation
protocol ListViewModelProtocol {
    var results: [Results]? { get }
    var errorMessage: String? { get }
    var resultsDidChange: (() -> Void)? { get set }
    var errorDidChange: (() -> Void)? { get set }
    func listItunesTrack() 
}
class ListViewModel: ListViewModelProtocol {
    
    var results: [Results]? {
        didSet {
            self.resultsDidChange?()
        }
    }
    
    var errorMessage: String? {
        didSet {
            self.resultsDidChange?()
        }
    }
    
    var resultsDidChange: (() -> Void)?
    var errorDidChange: (() -> Void)?
    
    func listItunesTrack() {
        Task {
            let manager = NetworkManager(session: URLSession.shared)
            do {
                let result =  try await manager.loadData(for: ITunesModel.self, from: NetworkProvider.baseUrl + NetworkProvider.path)
                self.results = result?.results
            } catch {
                if let error = error as? NetworkError {
                    self.errorMessage =  error.rawValue
                }
            }
        }
    }
    
}
