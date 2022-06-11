//
//  ProductsController.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import UIKit
import Combine

protocol ProductsControllerProtocol: BaseController {
    var onProductTapPublish: PassthroughSubject<Product, Never> { get }
}

final class ProductsController: BaseUIViewController, ProductsControllerProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    var onProductTapPublish = PassthroughSubject<Product, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: ProductViewModelProtocol!
    private var productsView: ProductsView! {
        willSet {
            self.view = newValue
        }
    }
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: ProductViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let productsView = ProductsView()
        self.productsView = productsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configureCollectionViewDataSourceAndDelegates()
        bindToDataStreamsAndUserInteractions()
    }
}

extension ProductsController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------
    private func bindToDataStreamsAndUserInteractions() {
        configureToCartDownStream()
        bindToLoadingState()
    }
    
    private func configureToCartDownStream() {
        viewModel.productListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] productsList in
                guard let self = self else { return }
                self.productsView.collectionView.reloadData()
        }.store(in: &subscriptions)
    }
    
    private func bindToLoadingState() {
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                guard let self = self else { return }
                self.setActivityIndicator = loadingState
            }.store(in: &subscriptions)
    }

    private func configureCollectionViewDataSourceAndDelegates() {
        productsView.collectionView.dataSource = self
        productsView.collectionView.delegate = self
        let collectionViewLayout = PinterestLayout()
        productsView.collectionView.collectionViewLayout = collectionViewLayout
        collectionViewLayout.delegate = self
        productsView.collectionView.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
    }
}

extension ProductsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.productListPublisher.value[indexPath.item]
        self.onProductTapPublish.send(product)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductCell else {
            fatalError("can not dequeueReusable Cell for the collection view")
        }
        let product = viewModel.getProduct(index: indexPath.item)
        cell.configure(with: product)
    }
}

extension ProductsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productListPublisher.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productCell, for: indexPath) as? ProductCell else {
            fatalError("can not dequeueReusable Cell for the collection view")
        }
        return cell
    }
}

extension ProductsController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(viewModel.productListPublisher.value[indexPath.item].image.height)
        return height
    }
}
