//
//  ImageSearchModule.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit

protocol ImageSearchModuleInput {
    func updateQuery(_ query: String)
    func loadMoreResults()
}

final class ImageSearchModuleOutput: FeatureModuleOutput {
    var viewModel: ImageSearchModuleInput

    init(viewController: UIViewController, viewModel: ImageSearchModuleInput) {
        self.viewModel = viewModel
        super.init(viewController: viewController)
    }
}

final class ImageSearchModule: FeatureModule<ImageSearchModuleOutput> {
    var input: ImageSearchModuleInput { output.viewModel }
}
