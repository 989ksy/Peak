//
//  Search.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import Foundation

// MARK: - Search
struct Search: Codable {
//    let lastBuildDate: String
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable, Hashable {
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


