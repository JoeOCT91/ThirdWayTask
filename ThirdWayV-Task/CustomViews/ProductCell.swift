//
//  ProductCell.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import UIKit
import Combine

class ProductCell: UICollectionViewCell {
    
    private let contentContainer = UIView(frame: .zero)
     let productImage = UIImageView(frame: .zero)
     let priceLabel = UILabel(frame: .zero)
    private let descriptionLabel = UILabel(frame: .zero)
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    private var padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabels()
        configureCellOuterBorder()
        //Layout cell sub views
//        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    
    func configure(with product: Product) {
        priceLabel.text = "\(product.price) $"
        descriptionLabel.text = product.productDescription
        cancellable = loadImage(for: product).sink { [unowned self] image in self.showImage(image: image) }
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
    
    
    private func configureLabels() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        priceLabel.textColor = UIColor.systemTeal
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        priceLabel.textAlignment = .center
    }
    
    private func configureCellOuterBorder() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.label.cgColor
    }
    
    private func layout() {
        layoutContentContainer()
        layoutProductImageView()
        layoutPriceLabel()
        layoutDescriptionLabel()
    }
    
    private func layoutContentContainer() {
        contentView.addSubview(contentContainer)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
        
    private func layoutProductImageView() {
        contentContainer.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),

        ])
    }
    
    private func layoutPriceLabel() {
        contentContainer.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor)
        ])
    }
    
    private func layoutDescriptionLabel() {
        contentContainer.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            //productImage.bottomAnchor.constraint(equalTo: priceLabel.topAnchor)
        ])
    }
    
}
