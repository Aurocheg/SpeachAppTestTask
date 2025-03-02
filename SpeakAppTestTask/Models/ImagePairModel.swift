//
//  ImagePairModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation

struct ImagePairModel {
    let firstImageURL: String
    let firstTags: String
    let secondImageURL: String
    let secondTags: String

    init(first: ImageDTO, second: ImageDTO) {
        self.firstImageURL = first.webformatURL
        self.firstTags = first.tags
        self.secondImageURL = second.webformatURL
        self.secondTags = second.tags
    }
}
