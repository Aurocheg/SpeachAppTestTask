//
//  ImagePreviewModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation

protocol ImagePreviewModel {
    var firstImageURL: String { get }
    var secondImageURL: String { get }
}

struct ImagePreviewDefaultModel: ImagePreviewModel {
    let firstImageURL: String
    let secondImageURL: String
    
    init(firstImageURL: String, secondImageURL: String) {
        self.firstImageURL = firstImageURL
        self.secondImageURL = secondImageURL
    }
}
