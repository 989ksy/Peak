//
//  SearchViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//

import UIKit
import SnapKit
import Kingfisher
import RealmSwift

class SearchViewController: BaseViewController {
    
    
    let mainView = SearchView()
    var searchList : Search = Search(total: 0, start: 0, display: 0, items: [])
    
    var tasks: Results<Shopping>!
    let repository = ShoppingRepository()
    
//페이지네이션 + 검색
    var page = 1 //start
    var total = 0
    var display = 30
    var isEnd = false
    var sort = "sim"
    var searchQuery: String?
    
    var tableData : Shopping?
    
    
    override func loadView() {
        let view = mainView
        self.view = view
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.collectionView.reloadData()
    }
    
    
    override func configureView() {
        super.configureView()
        
        repository.getFileURL()
        tasks = repository.fetch()
        
    //네비게이션 영역
        title = "상품 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    //서치바
        mainView.searchbar.delegate = self
        
    //컬렉션뷰 연결
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    //페이지네이션
        mainView.collectionView.prefetchDataSource = self
        
    //서치뷰 collectionView reloadData 처리
        mainView.requestReloadDataHandler = {
        self.mainView.collectionView.reloadData()
        }
    
        
    }
    
    
    
    
    override func setConstraints() {}
    
    
}


//서치바 (검색기능 구현)

extension SearchViewController: UISearchBarDelegate {
    
//네트워크 통신 세팅
    func searchQuery (query: String) {
//        searchQuery = query
        searchList.items.removeAll()

        SearchAPIManager.shared.callRequest(query: query, sort: sort, page: page, display: 30) { data in
            self.searchList = data
            self.mainView.collectionView.reloadData()
        } failure: {
            print("검색 안된다.")
        }
        
        mainView.collectionView.reloadData()
    }
    
//검색버튼 클릭시 검색 진행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchList.items.removeAll()
        guard let text = searchBar.text else { return }
        searchQuery(query: text)
    }
    
//취소버튼 클릭시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchList.items.removeAll()
        mainView.collectionView.reloadData()
        
    }
    
}




//컬렉션뷰

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }

    //indexPath.row 설정
        let data = searchList.items[indexPath.row]
        cell.data = data
        
    //셀 설정
        if let imageURL = URL(string: data.image!) {
            cell.productImage.kf.setImage(with: imageURL)
        }
        
        let removeHTMLText = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) //검색어 특수문자 제거
        cell.productNameLabel.text = removeHTMLText
        cell.storeNameLabel.text = data.mallName
        cell.priceLabel.text = data.lprice

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ProductViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        let data = searchList.items[indexPath.row]
        vc.sharedData = data
        
    }

}


//페이지네이션

extension SearchViewController : UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if searchList.items.count - 1 == indexPath.row && page < searchList.total && isEnd == false {
                page += 1
                
                if let query = mainView.searchbar.text {
                    SearchAPIManager.shared.callRequest(query: query, sort: sort, page: page, display: display) { data in
                        
                        self.searchList.items.append(contentsOf: data.items)
                        self.mainView.collectionView.reloadData()

                        
                    } failure: {
                        print("페이지네이션 실패")
                    }
                }

            }
        }
        
        print("===\(indexPaths)")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
        
    }
    
    
    
}
