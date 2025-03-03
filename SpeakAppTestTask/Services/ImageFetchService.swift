//
//  ImageFetchService.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation
import Combine

protocol ImageFetchService: AnyObject {
    func fetchImages(query: String, page: Int) -> AnyPublisher<[ImageDTO], Never>
}

final class ImageFetchDefaultService: ImageFetchService {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    func fetchImages(query: String, page: Int) -> AnyPublisher<[ImageDTO], Never> {
        let endpoint = APIConfiguration.searchEndpoint(query: query, page: page)
        
        guard let requestURL = URL(string: endpoint) else {
            return Just([]).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .map { $0.data }
            .decode(type: PixabayResponseDTO.self, decoder: decoder)
            .map { $0.hits }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
