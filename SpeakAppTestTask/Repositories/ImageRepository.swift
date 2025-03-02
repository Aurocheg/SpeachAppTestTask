//
//  ImageRepository.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation
import Combine

protocol ImageRepository: AnyObject {
    func fetchImages(query: String, page: Int) -> AnyPublisher<[ImagePairModel], Never>
    func clearImageCacheIfNeeded()
}

final class ImageDefaultRepository: ImageRepository {
    private let fetchService: ImageFetchService
    private let cacheService: ImageCacheService

    init(fetchService: ImageFetchService, cacheService: ImageCacheService) {
        self.fetchService = fetchService
        self.cacheService = cacheService
    }

    func fetchImages(query: String, page: Int) -> AnyPublisher<[ImagePairModel], Never> {
        let publisher1 = fetchService.fetchImages(query: query, page: page)
        let publisher2 = fetchService.fetchImages(query: query + " graffiti", page: page)

        return Publishers.Zip(publisher1, publisher2)
            .map { firstImages, secondImages in
                zip(firstImages, secondImages).map { ImagePairModel(first: $0, second: $1) }
            }
            .eraseToAnyPublisher()
    }
    
    func clearImageCacheIfNeeded() {
        cacheService.clearCacheIfNeeded()
    }
}
