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
    var savedData : Shopping?
    var data : Item?
    
    //파일경로-Realm 테이블확인
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    //저장데이터 확인 (좋아요 버튼 데이터 확인용)
    func IsSavedData (productID: Int) -> Bool {
        guard let data = data else { return false }
        let result = realm.objects(Shopping.self).where {
            $0.productId == data.productID
        }
        return true
    }
    
    //검색하기 (FavVC, 제품명만 가져온다.)
    func fetchProductNameFilter(productName: String) -> Results<Shopping> {
        
        let result = realm.objects(Shopping.self).where {
            $0.productName.contains(productName)
        }
        return result
    }
    
    
    //삭제
    func deleteData(_productID: Int) {
        guard let  getSavedDate = realm.objects(Shopping.self).filter("productID").first else {return}
        do {
            try realm.write {
                realm.delete(getSavedDate)
            }
        } catch {
            print("삭제 실패")
        }
    }
    
    //가져오기 (FavVC, 최신순 정렬)
    func fetch() -> Results<Shopping> {
        let data = realm.objects(Shopping.self).sorted(byKeyPath: "date", ascending: false )
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
    
    
    //저장 (Realm에 저장)
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
    
    func updateItem(productId: String, like: Bool) {
        do {
            try realm.write{
                print("likeButton", like)
                realm.create(Shopping.self, value: ["productId": productId, "favorite": like], update: .modified)
                print("좋아요 저장 업데이트!")
            }
        } catch {
            print("좋아요 저장 실패: \(error)")
        }
    }
    
    
    
}
