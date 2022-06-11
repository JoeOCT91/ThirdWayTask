//
//  NetworkManager .swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 08/06/2022.
//

import Foundation
import Combine

class NetworkManager {
    
    class func getProducts(cacheHandler: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) -> AnyPublisher<[Product], NetworkError> {
        return request(target: APIRouter.products, cacheHandler: .returnCacheDataElseLoad)
    }
}

extension NetworkManager {
    
    private static func request<T: Decodable>(target: APIRouter, cacheHandler: URLRequest.CachePolicy) -> AnyPublisher<T, NetworkError> {
        return try! request(urlRequest: target.asURLRequest(cacheHandler: cacheHandler))
    }
    
    private static func request<T: Decodable>(urlRequest: URLRequest) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest).tryMap { (data: Data, response: URLResponse) in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.badAPIRequest
            }
            return data
        }.mapError { error -> NetworkError in
            if let error = error as? NetworkError {
                return error
            } else {
                return NetworkError.badAPIRequest
            }
        }.decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.encodingFailed
            }
            .eraseToAnyPublisher()
    }
    
}
