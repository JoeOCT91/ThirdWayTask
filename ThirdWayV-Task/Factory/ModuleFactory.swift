//
//  ModuleFactory.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import Foundation
//
//  ModuleFactory.swift
//  ZwadatkomIos
//
//  Created by Yousef Mohamed on 15/05/2022.
//

import Foundation


final class ModuleFactory {}

extension ModuleFactory: MainModuleFactory {
        
    func createProductsOutput() -> ProductsControllerProtocol {
        let viewModel = ProductsViewModel()
        return ProductsController(viewModel: viewModel)
    }
    
    func createProductDetailsHandler(with product: Product) -> ProductDetailsControllerProtocol {
        let viewModel = ProductsDetailsViewModel(product: product)
        return ProductDetailsController(viewModel: viewModel)
    }
}


