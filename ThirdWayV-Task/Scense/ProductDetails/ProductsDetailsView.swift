//
//  ProductsDetailsView.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 10/06/2022.
//

import UIKit
import Combine

class ProductDetailsView: UIView {
    
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView(frame: .zero)
    private let productImage = UIImageView(frame: .zero)
    private let productDescriptionLabel = UILabel(frame: .zero)
    let dismissButton = UIButton(frame: .zero)
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureProductImage()
        configureLabel()
        configureDismissButton()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with product: Product) {
        cancellable = loadImage(for: product).sink { [unowned self] image in self.showImage(image: image) }
        productDescriptionLabel.text = product.productDescription
    }
    
    private func showImage(image: UIImage?) {
        productImage.alpha = 0.0
        animator?.stopAnimation(false)
        productImage.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.productImage.alpha = 1.0
        })
    }
    
    private func loadImage(for product: Product) -> AnyPublisher<UIImage?, Never> {
        return Just(product.image.url)
            .flatMap({ imageUrl -> AnyPublisher<UIImage?, Never> in
                let url = URL(string:imageUrl)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
    
    private func configureLabel() {
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.textAlignment = .center
        productDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    private func configureProductImage() {
        productImage.contentMode = .scaleToFill
        productImage.layer.cornerRadius = 12
    }
    
    private func configureDismissButton() {
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.backgroundColor = .systemGray
        dismissButton.layer.cornerRadius = 12
    }
    
    private func layout() {
        layoutSCrollView()
        layoutContentView()
        layoutProductImage()
        layoutDescriptionLabel()
        layoutDismissButton()
    }
    
    private func layoutSCrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func layoutContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo:  scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo:  scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo:   scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
    
    private func layoutProductImage() {
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18)
        ])
        
    }
    private func layoutDescriptionLabel() {
        contentView.addSubview(productDescriptionLabel)
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productDescriptionLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 16),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
        ])
    }
    
    private func layoutDismissButton() {
        contentView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 16),
            dismissButton.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        ])
    }
    
    
}
