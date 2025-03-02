//
//  RepositoryAssembly.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImageRepository.self) { resolver in
            ImageDefaultRepository(
                fetchService: resolver.resolve(ImageFetchService.self)!,
                cacheService: resolver.resolve(ImageCacheService.self)!
            )
        }
    }
}
