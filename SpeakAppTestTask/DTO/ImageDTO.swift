//
//  ImageDTO.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation

struct ImageDTO: Decodable {
    let webformatURL: String
    let tags: String
}

struct PixabayResponse: Decodable {
    let hits: [ImageDTO]
}
