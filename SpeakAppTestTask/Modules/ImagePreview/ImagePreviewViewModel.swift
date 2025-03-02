//
//  ImagePreviewViewModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation

final class ImagePreviewViewModel: ImagePreviewModuleInput {
    @Published private(set) var currentImageURL: String
    private var isShowingFirstImage = true
    private let model: ImagePreviewModelProtocol
    
    init(model: ImagePreviewModelProtocol) {
        self.model = model
        self.currentImageURL = model.firstImageURL
    }
    
    func toggleImage() {
        isShowingFirstImage.toggle()
        currentImageURL = isShowingFirstImage ? model.firstImageURL : model.secondImageURL
    }
}
