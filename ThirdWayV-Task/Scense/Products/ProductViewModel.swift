//
//  ProductViewModel.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import Foundation
import Combine

protocol ProductViewModelProtocol: AnyObject {
    var isLoadingPublisher: CurrentValueSubject<Bool, Never> { get }
    var productListPublisher: CurrentValueSubject<[Product], Never>{ get }
    func getProduct(index: Int) -> Product

}

final class ProductsViewModel: ProductViewModelProtocol {
    
    private var subscriptions = Set<AnyCancellable>()
    
    let isLoadingPublisher = CurrentValueSubject<Bool, Never>(false)
    let productListPublisher = CurrentValueSubject<[Product], Never>([Product]())
    
    @Published private var nextItem = 0
    
    init() {
        fetchProductsList()
        observeNextItem()
    }
    
    // safe retrieve product for cell
    func getProduct(index: Int) -> Product {
        guard let product = productListPublisher.value[safe: index] else {
            fatalError()
        }
        self.nextItem = index
        return product
    }
    private func observeNextItem() {
        $nextItem
            .dropFirst()
            .sink { [weak self] nextItem in
                guard let self = self else { return }
                // load new list of products before the end of current list
                if nextItem + 4 == self.productListPublisher.value.count {
                    self.fetchProductsList()
                }
        }.store(in: &subscriptions)
    }

    private func fetchProductsList() {
        let reachability = try? Reachability()
        switch reachability?.connection {
        case .unavailable:
            fetchProductsList(cacheHandler: .returnCacheDataDontLoad)
        case .wifi, .cellular:
            fetchProductsList(cacheHandler: .reloadRevalidatingCacheData)
        default:
            break
        }
    }
    private func fetchProductsList(cacheHandler: URLRequest.CachePolicy) {
        NetworkManager.getProducts(cacheHandler: cacheHandler)
            .sink { [weak self] completion in
            guard let self = self else { return }
            self.isLoadingPublisher.send(false)

            guard case .failure(let error) = completion else { return }
            switch error {
            case .noInternet:
                break
            case .badAPIRequest:
                break
            case .unauthorized:
                break
            case .unknown:
                break
            case .serverError:
                break
            case .timeout:
                break
            case .noUrl:
                break
            case .encodingFailed:
                break
            }
        } receiveValue: { [weak self] productsList in
            guard let self = self else { return }
            self.productListPublisher.value.append(contentsOf: productsList)
        }.store(in: &subscriptions)
    }
}


