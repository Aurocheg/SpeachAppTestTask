//
//  ImageSearchModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation
import Combine

protocol ImageSearchModel: AnyObject {
    func fetchImages(query: String, page: Int) -> AnyPublisher<[ImagePairModel], Never>
    func clearImageCacheIfNeeded()
}

final class ImageSearchDefaultModel: ImageSearchModel {
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func fetchImages(query: String, page: Int) -> AnyPublisher<[ImagePairModel], Never> {
        repository.fetchImages(query: query, page: page)
    }
    
    func clearImageCacheIfNeeded() {
        repository.clearImageCacheIfNeeded(maxMegabytesInMemory: 200)
    }
}
