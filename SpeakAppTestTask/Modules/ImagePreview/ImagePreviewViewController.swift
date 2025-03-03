//
//  ImagePreviewViewController.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit
import SnapKit
import Combine

final class ImagePreviewViewController: UIViewController {
    private let viewModel: ImagePreviewViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var closeButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Switch Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(toggleImage), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: ImagePreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        view.addSubview(closeButton)
        view.addSubview(toggleButton)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(15)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    private func bindViewModel() {
        viewModel.$currentImageURL
            .receive(on: DispatchQueue.main)
            .sink { [weak self] url in
                self?.imageView.kf.setImage(with: URL(string: url))
            }
            .store(in: &cancellables)
    }
    
    @objc private func closeTapped() {
        viewModel.closeInitiated(viewController: self)
    }
    
    @objc private func toggleImage() {
        viewModel.toggleImageInitiated()
    }
}
