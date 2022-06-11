//
//  Product.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import Foundation

import Foundation

struct Product: Codable, Hashable {
    let id: Int
    let productDescription: String
    let image: ProductImage
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case productDescription
        case image
        case price
    }
    
    private let identifier = UUID()
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: Product, rhs: Product) -> Bool {
      return lhs.identifier == rhs.identifier
    }
}

