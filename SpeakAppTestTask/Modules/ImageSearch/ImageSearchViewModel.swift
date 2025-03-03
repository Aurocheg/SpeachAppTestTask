//
//  ImageSearchViewModel.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit
import Combine

protocol ImageSearchModuleInput: AnyObject {
    func updateQuery(_ query: String)
    func loadMoreResults()
    func openImagePreview(from viewController: UIViewController, index: Int)
}

final class ImageSearchViewModel: ImageSearchModuleInput {
    @Published var items: [ImagePairModel] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var currentQuery = ""
    private var hasMoreResults = true
    
    private let model: ImageSearchModel
    private let router: ImageSearchRouter
    
    init(model: ImageSearchModel, router: ImageSearchRouter) {
        self.model = model
        self.router = router
    }
    
    func updateQuery(_ query: String) {
        guard !query.isEmpty else { return }
        isLoading = true
        currentQuery = query
        currentPage = 1
        hasMoreResults = true
        
        model.clearImageCacheIfNeeded()
        
        model.fetchImages(query: query, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                },
                receiveValue: { [weak self] images in
                    self?.items = images
                    self?.hasMoreResults = !images.isEmpty
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreResults() {
        guard !isLoading, hasMoreResults else { return }
        isLoading = true
        currentPage += 1
        
        model.clearImageCacheIfNeeded()
        
        model.fetchImages(query: currentQuery, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                },
                receiveValue: { [weak self] images in
                    self?.items.append(contentsOf: images)
                    self?.hasMoreResults = !images.isEmpty
                }
            )
            .store(in: &cancellables)
    }
    
    func openImagePreview(from viewController: UIViewController, index: Int) {
        let selectedItem = items[index]
        router.openImagePreview(from: viewController, firstImageURL: selectedItem.firstImageURL, secondImageURL: selectedItem.secondImageURL)
    }
}
