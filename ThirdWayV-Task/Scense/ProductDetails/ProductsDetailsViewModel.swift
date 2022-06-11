//
//  ProductsDetailsViewModel.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 10/06/2022.
//

import Foundation

protocol ProductsDetailsViewModelProtocol: AnyObject {
    var productPublisher: Published<Product>.Publisher { get }
}

class ProductsDetailsViewModel: ProductsDetailsViewModelProtocol {
    
    @Published private var product: Product
    var productPublisher: Published<Product>.Publisher { $product }

    init(product: Product) {
        self.product = product
    }
    
}
