//
//  NetworkProvider.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import Foundation
struct NetworkProvider {
    static let baseUrl = GlobalVariables.propertyListValues?[Constants.Keys.serverUrl] as? String ?? ""
    static let path =  "/search?term=jack+johnson"
}
