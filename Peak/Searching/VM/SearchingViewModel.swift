//
//  SearchViewModel.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/24/23.
//

import Foundation
import RealmSwift


class SearchingViewModel {
    
    var searchList : Search = Search(total: 0, start: 0, display: 0, items: [])
    
    let repository = ShoppingRepository()
    var tasks: Results<Shopping>!
    
    var data: Item? //코더블 객체(API)
    var shoppingData : Shopping?
    
    
    //MARK: - 페이지네이션
    
    var page = 1 //start, 페이지네이션
    var total = 0 // 페이지네이션
    
    var sort = "sim" //기본값, 페이지네이션 & 정렬
    var display = 30 // 페이지네이션 & 정렬
    var isEnd = false //페이지네이션
    
    var buttonTapped = false //버튼 토글
    var start = 1 // 정렬
    var query = "캠핑" // 정렬
    
}
