//
//  ImagePreviewRouter.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 3.03.25.
//

import UIKit

protocol ImagePreviewRouter: AnyObject {
    func dismiss(viewController: UIViewController)
}

final class ImagePreviewDefaultRouter: ImagePreviewRouter {
    func dismiss(viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
}
