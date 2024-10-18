//
//  Cart.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/18/24.
//

struct CartResponse: Codable {
    let carts: [Cart]
    let total, skip, limit: Int
}

// MARK: - Cart
struct Cart: Codable {
    let id: Int
    let products: [Product]
    let total, discountedTotal: Double
    let userID, totalProducts, totalQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id, products, total, discountedTotal
        case userID = "userId"
        case totalProducts, totalQuantity
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let quantity: Int
    let total, discountPercentage, discountedTotal: Double
    let thumbnail: String
}
