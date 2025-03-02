//
//  ImagePreviewModule.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit

protocol ImagePreviewModuleInput {
   func toggleImage()
}

final class ImagePreviewModuleOutput: FeatureModuleOutput {
    var viewModel: ImagePreviewModuleInput

    init(viewController: UIViewController, viewModel: ImagePreviewModuleInput) {
        self.viewModel = viewModel
        super.init(viewController: viewController)
    }
}

final class ImagePreviewModule: FeatureModule<ImagePreviewModuleOutput> {
    var input: ImagePreviewModuleInput { output.viewModel }
}
