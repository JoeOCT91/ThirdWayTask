//
//  ProductImage.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import Foundation

struct ProductImage: Codable, Hashable {
    let width, height: Int
    let url: String
    
    
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case url
    }
    
    private let identifier = UUID()
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: ProductImage, rhs: ProductImage) -> Bool {
      return lhs.identifier == rhs.identifier
    }
}
