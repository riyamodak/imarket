//
//  ProductModel.swift
//  imarket
//
//  Created by riya on 8/26/24.
//

import Foundation

struct Product: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let thumbnail: String
    let tags: [String]
}

struct ProductResponse: Codable {
    let products: [Product]
}
