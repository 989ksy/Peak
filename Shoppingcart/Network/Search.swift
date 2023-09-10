//
//  Search.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//

import Foundation

// MARK: - Search
struct Search: Codable {
//    let lastBuildDate: String
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String?
    let lprice, hprice: String
    let mallName: String
    let productID: String
    var like: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName //productID
        case productID = "productId"
    }
}


