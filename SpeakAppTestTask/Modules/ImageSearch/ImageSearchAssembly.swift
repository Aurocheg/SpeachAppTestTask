//
//  ImageSearchAssembly.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation
import Swinject

public final class ImageSearchAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(ImageSearchModule.self) { resolver in
            let model = ImageSearchDefaultModel(
                repository: resolver.resolve(ImageRepository.self)!
            )
            let router = ImageSearchDefaultRouter()
            let viewModel = ImageSearchViewModel(model: model, router: router)
            let viewController = ImageSearchViewController(viewModel: viewModel)
            let module = ImageSearchModule(output: .init(viewController: viewController, viewModel: viewModel))
            return module
        }
    }
    
    public init() {}
}
