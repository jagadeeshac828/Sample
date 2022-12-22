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
        let manager = NetworkManager(session: URLSession.shared)
        manager.loadData(for: ITunesModel.self, from: NetworkProvider.baseUrl + NetworkProvider.path) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let results = data.results {
                        self?.results = results
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if let error = error as? NetworkError {
                        self?.errorMessage =  error.rawValue
                    } else {
                        self?.errorMessage = error.localizedDescription
                    }
                }
                
            }
        }
    }
    
}
