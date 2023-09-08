//
//  ShoppingRepository.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/08.
//

import Foundation
import RealmSwift

protocol ShoppingRepositoryType: AnyObject {
    
}

class ShoppingRepository: ShoppingRepositoryType {
    
    private let realm = try! Realm()
    
    //파일경로-Realm 테이블확인
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    //세팅
    
    func fetch() -> Results<Shopping> {
        let data = realm.objects(Shopping.self).sorted(byKeyPath: "productName")
        return data
    }
    
    //필터
    
    func fetchFavoriteFilter() -> Results<Shopping> {
        
        //좋아요인 것만 보여줘
        let result = realm.objects(Shopping.self).where {
            $0.favorite == true
        }
        
        return result
        
    }
    
    //저장
    
    func createItem(_ item: Shopping){
        
        do{
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
        
    }
    
    //업데이트
    
    func updateItem(id: ObjectId, like: Bool) {
        do {
            try realm.write{
                print("likeButton", like)
                realm.create(Shopping.self, value: ["_id": id, "favorite": like], update: .modified)
                print("좋아요 저장 업데이트!")
            }
        } catch {
            print("좋아요 저장 실패: \(error)")
        }
    }
    
    
    
}
