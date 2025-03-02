//
//  APIConfiguration.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation

struct APIConfiguration {
    static let baseURL = "https://pixabay.com/api/"
    static let apiKey = "38738026-cb365c92113f40af7a864c24a"
    
    static func searchEndpoint(query: String, page: Int) -> String {
        return "\(baseURL)?key=\(apiKey)&q=\(query)&page=\(page)"
    }
}
