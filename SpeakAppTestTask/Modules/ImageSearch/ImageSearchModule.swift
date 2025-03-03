//
//  ImageSearchModule.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit

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
