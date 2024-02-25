//
//  Shopping.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import Foundation
import RealmSwift

class Shopping: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var productImage: String?
    @Persisted var productName: String
    @Persisted var storeName: String
    @Persisted var price: String
    @Persisted var webLink: String
    @Persisted var favorite: Bool
    @Persisted var date: Date
    @Persisted var productId: String
    
    convenience init(productImage: String?, productName: String, storeName: String, price: String, webLink: String, favorite: Bool, date: Date, productId: String) {
        self.init()
        
        self.productImage = productImage
        self.productName = productName
        self.storeName = storeName
        self.price = price
        self.webLink = webLink
        self.favorite = favorite
        self.date = date
        self.productId = productId
        
    }
    
    
}

