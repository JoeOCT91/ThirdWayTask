//
//  MaiModuleFactory.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import Foundation

protocol MainModuleFactory {
    func createProductsOutput() -> ProductsControllerProtocol
    func createProductDetailsHandler(with product: Product) -> ProductDetailsControllerProtocol
}
