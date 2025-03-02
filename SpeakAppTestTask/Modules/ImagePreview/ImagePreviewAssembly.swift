//
//  ImagePreviewAssembly.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Swinject

final class ImagePreviewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImagePreviewModule.self) { (resolver, firstImageURL: String, secondImageURL: String) in
            let model = ImagePreviewModel(firstImageURL: firstImageURL, secondImageURL: secondImageURL)
            let viewModel = ImagePreviewViewModel(model: model)
            let viewController = ImagePreviewViewController(viewModel: viewModel)
            return .init(
                output: .init(
                    viewController: viewController,
                    viewModel: viewModel
                )
            )
        }
    }
    
    public init() {}
}
