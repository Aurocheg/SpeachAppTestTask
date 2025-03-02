//
//  ServiceAssembly.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Swinject

final class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImageFetchService.self) { _ in
            ImageFetchDefaultService()
        }
        
        container.register(ImageCacheService.self) { _ in
            ImageCacheDefaultService()
        }
    }
}
