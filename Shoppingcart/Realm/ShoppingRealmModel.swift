//
//  ShoppingRealmModel.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/08.
//

import Foundation
import RealmSwift

class Shopping: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var productImage: String?
    @Persisted var productName: String
    @Persisted var storeName: String
    @Persisted var price: Int
    @Persisted var webLink: String
    @Persisted var favorite: Bool
    @Persisted var date = Date()
    
    convenience init(productImage: String?, productName: String, storeName: String, price: Int, webLink: String, favorite: Bool, date: Date) {
        self.init()
        
        self.productImage = productImage
        self.productName = productName
        self.storeName = storeName
        self.price = price
        self.webLink = webLink
        self.favorite = favorite
        
    }
    
    
}
