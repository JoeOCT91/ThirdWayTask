//
//  ProductsDetailsController.swift
//  NetworkManager
//
//  Created by Yousef Mohamed on 07/06/2022.
//

import UIKit
import Combine

protocol ProductDetailsControllerProtocol: BaseController {
}

final class ProductDetailsController: UIViewController, ProductDetailsControllerProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    var onProductTapPublish = PassthroughSubject<Product, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: ProductsDetailsViewModelProtocol!
    var productDetailsView: ProductDetailsView! {
        willSet {
            self.view = newValue
        }
    }
    
    var tempImageView: UIImageView!
    var tempImageInitialFrame: CGRect!
    var interactiveTransition: UIPercentDrivenInteractiveTransition!

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: ProductsDetailsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let productDetailsView = ProductDetailsView()
        self.productDetailsView = productDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToDataStreamsAndUserInteractions()
    }
}

extension ProductDetailsController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------
    private func bindToDataStreamsAndUserInteractions() { bindToProductDownStream() }
    
    private func bindToProductDownStream() {
        viewModel.productPublisher.sink { [weak self] product in
            guard let self = self else { return }
            self.productDetailsView.configureView(with: product)
        }.store(in: &subscriptions)
        
        productDetailsView.dismissButton.tapPublisher(for: .touchUpInside).sink { _ in
            self.dismiss(animated: true)
        }.store(in: &subscriptions)
    }
}



