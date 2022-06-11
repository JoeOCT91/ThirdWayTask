//
//  EndPoint.swift
//  NetworkManager
//
//  Created by Yousef Mohamed on 08/06/2022.
//


import Foundation

public struct EndPoint: RawRepresentable, Equatable, Hashable {
    /// Base url 
    public static let baseURL = EndPoint(rawValue: "https://7844fb16-51aa-4ef6-8960-37bc9fe01099.mock.pstmn.io")


    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
