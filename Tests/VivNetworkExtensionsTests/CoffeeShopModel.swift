//
//  CoffeeShopModel.swift
//  VivNetworkExtensionsTests
//
//  Created by Vivian Phung on 2/23/23.
//

import Foundation

struct CoffeeShopModel: Codable, Equatable {
    var name: String

    static func ==(lhs: CoffeeShopModel, rhs: CoffeeShopModel) -> Bool {
        return lhs.name == rhs.name
    }
}
