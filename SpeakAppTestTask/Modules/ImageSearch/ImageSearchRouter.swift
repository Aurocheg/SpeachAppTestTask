//
//  ImageSearchRouter.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit

protocol ImageSearchRouter: AnyObject {
    func openImagePreview(from viewController: UIViewController, firstImageURL: String, secondImageURL: String)
}

final class ImageSearchDefaultRouter: ImageSearchRouter {
    func openImagePreview(from viewController: UIViewController, firstImageURL: String, secondImageURL: String) {
        let previewModule = AppDependencyContainer.shared.resolve(
            ImagePreviewModule.self,
            arguments: firstImageURL, secondImageURL
        )
        viewController.present(previewModule.presentation, animated: true, completion: nil)
    }
}
