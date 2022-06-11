//
//  ApplicationCoordinator.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import UIKit
import Combine


class ApplicationCoordinator: BaseCoordinator {
    
    private let factory: MainModuleFactory
    private let router: RouterProtocol
    

    init(router: RouterProtocol, factory: MainModuleFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showProductsScene()
    }
    
    private func showProductsScene() {
        let productsOutput = factory.createProductsOutput()
        productsOutput.onProductTapPublish.sink { [weak self] product in
            guard let self = self else { return }
            self.showProductDetails(with: product)
        }.store(in: &subscriptions)
        self.router.setRootModule(productsOutput)
    }
    
    private func showProductDetails(with product: Product) {
        let productDetailsHandler = factory.createProductDetailsHandler(with: product)
        router.present(productDetailsHandler)
    }
}
