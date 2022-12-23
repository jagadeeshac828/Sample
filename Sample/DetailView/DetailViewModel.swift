//
//  DetailViewModel.swift
//  Sample
//
//  Created by Jagadeesha on 22/12/22.
//

import Foundation
protocol DetailViewModelProtocol {
    func constructDataForLabel(_ result: Results) -> String
}
class DetailViewModel: DetailViewModelProtocol {
    
    // This method for construct data from response
    func constructDataForLabel(_ result: Results) -> String {
        let data =
                    """
                    \(Constants.trackName) - \(result.trackName ?? "")
                    \(Constants.artistName) - \(result.artistName ?? "")
                    """
        return data
        
    }
}
