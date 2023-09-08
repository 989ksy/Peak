//
//  SearchAPIManager.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/08.
//

import Foundation
import Alamofire

class SearchAPIManager {
    
    static let shared = SearchAPIManager()
    
    func callRequest(query: String, page:Int, display: Int, success: @escaping (Search) -> (), failure: @escaping () -> () ){
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        print("===SearchAPIManager query(text)")
        guard let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(text)&display=\(display)&start=\(page)") else { return }
        print("===SearchAPIManager url", url)
        let header: HTTPHeaders = ["X-Naver-Client-Id":"\(APIKey.naverID)", "X-Naver-Client-Secret":"0IJXcAfwGn"]
        
        AF.request(url, headers: header).validate(statusCode: 200...500).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
                print("===BookAPIManager", value)
            case .failure(let error):
                print("===API Networking Failure",error)
            }
        }
        
        
    }
    
    
}
