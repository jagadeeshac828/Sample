//
//  ListViewModel.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import Foundation
class ListViewModel {
    func callItunesAPI(completionHandler: @escaping (Result<ITunesModel, Error>) -> Void) {
        let manager = NetworkManager(session: URLSession.shared)
        manager.loadData(for: ITunesModel.self, from: NetworkProvider.baseUrl + NetworkProvider.path) { result in
            completionHandler(result)
        }
    }
}
