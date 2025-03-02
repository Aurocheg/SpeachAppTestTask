//
//  ImageSearchViewModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit
import Combine

final class ImageSearchViewModel: ImageSearchModuleInput {
    @Published var items: [ImagePairModel] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    
    private let model: ImageSearchModel
    private let router: ImageSearchRouter
    
    init(model: ImageSearchModel, router: ImageSearchRouter) {
        self.model = model
        self.router = router
    }
    
    public func updateQuery(_ query: String) {
        guard !query.isEmpty else { return }
        isLoading = true
        model.clearImageCacheIfNeeded()
        
        model.fetchImages(query: query, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.isLoading = false
            } receiveValue: { images in
                self.items = images
            }
            .store(in: &cancellables)
    }
    
    public func loadMoreResults() {
        guard !isLoading else { return }
        currentPage += 1
        updateQuery("")
    }
    
    public func openImagePreview(from viewController: UIViewController, index: Int) {
        let selectedItem = items[index]
        router.openImagePreview(from: viewController, firstImageURL: selectedItem.firstImageURL, secondImageURL: selectedItem.secondImageURL)
    }
}
