//
//  SearchViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    var searchList : Search = Search(total: 0, start: 0, display: 0, items: [])
    
    var page = 1
    var display = 30
    var isEnd = false
    var searchQuery: String?
    
    override func loadView() {
        let view = mainView
        self.view = view
        
    }
    
    override func configureView() {
        super.configureView()
        
        //네비게이션 영역
        title = "상품 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        //서치바
        mainView.searchbar.delegate = self
        
        //컬렉션뷰 연결
        mainView.collectionView.dataSource = self
        mainView.collectionView.dataSource = self
        
        //페이지네이션
        mainView.collectionView.prefetchDataSource = self
        
        
        //네트워크통신 확인
//        SearchAPIManager.shared.callRequest(query: "골프채") { data in
//            print(data)
//        } failure: {
//            print("error")
//        }

        
    }
    
    override func setConstraints() {
        
    }
    
    
    
    
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchQuery (query: String) {
        searchQuery = query
        searchList.items.removeAll()

        SearchAPIManager.shared.callRequest(query: query, page: page, display: 30) { data in
            self.searchList = data
            self.mainView.collectionView.reloadData()
            
        } failure: {
            print("검색 안된다.")
        }
        
        mainView.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        searchList.items.removeAll()
        guard let text = searchBar.text else { return }
        searchQuery(query: text)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchList.items.removeAll()
        mainView.collectionView.reloadData()
        
    }
    
}


extension SearchViewController : UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if searchList.items.count - 1 == indexPath.row && isEnd == false {
                page += 1
                if let query = searchQuery{
                    SearchAPIManager.shared.callRequest(query: query, page: page, display: display) { data in
                        
                        if data.items.isEmpty {
                            self.isEnd = true
                        } else {
                            self.searchList = data
                            self.mainView.collectionView.reloadData()
                        }
                    } failure: {
                        print("페이지네이션 실패")
                    }
                }

            }
        }
        
    }
    
}


extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let data = searchList.items[indexPath.row]
        
//        guard let url = data.image else { return "" }
        
        if let imageURL = URL(string: data.image!) {
            cell.productImage.kf.setImage(with: imageURL)
        }
        
        let removeHTMLText = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        cell.productNameLabel.text = removeHTMLText//data.title
        cell.storeNameLabel.text = data.mallName
        cell.priceLabel.text = data.lprice
        

        return cell

    }

}
