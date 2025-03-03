//
//  ImagePreviewViewModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit

protocol ImagePreviewModuleInput: AnyObject {
    func toggleImageInitiated()
    func closeInitiated(viewController: UIViewController)
}

final class ImagePreviewViewModel: ImagePreviewModuleInput {
    @Published private(set) var currentImageURL: String
    private var isShowingFirstImage = true
    
    private let model: ImagePreviewModel
    private let router: ImagePreviewRouter
    
    init(model: ImagePreviewModel, router: ImagePreviewRouter) {
        self.model = model
        self.router = router
        self.currentImageURL = model.firstImageURL
    }
    
    func toggleImageInitiated() {
        isShowingFirstImage.toggle()
        currentImageURL = isShowingFirstImage ? model.firstImageURL : model.secondImageURL
    }
    
    func closeInitiated(viewController: UIViewController) {
        router.dismiss(viewController: viewController)
    }
}
