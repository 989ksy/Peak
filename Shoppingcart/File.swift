////
////  File.swift
////  Shoppingcart
////
////  Created by Seungyeon Kim on 2023/09/09.
////
//
//import Foundation
//
////
////  SearchViewController.swift
////  Shoppingcart
////
////  Created by Seungyeon Kim on 2023/09/07.
////
//
//import UIKit
//import SnapKit
//import Kingfisher
//import RealmSwift
//
//class SearchViewController: BaseViewController {
//
//
//    let mainView = SearchView()
//    var searchList : Search = Search(total: 0, start: 0, display: 0, items: [])
//
//    var tasks: Results<Shopping>!
//    let repository = ShoppingRepository()
//
//    //페이지네이션 + 검색
//    var page = 1 //start
//    var total = 0
//    var display = 30
//    var isEnd = false
//    var sort = "sim"
//    var searchQuery: String?
//
//    var tableData : Shopping?
//
//
//    override func loadView() {
//        let view = mainView
//        self.view = view
//
//    }
//
//    override func configureView() {
//        super.configureView()
//
//        repository.getFileURL()
//        tasks = repository.fetch()
//
//        //네비게이션 영역
//        title = "상품 검색"
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//        //서치바
//        mainView.searchbar.delegate = self
//
//        //컬렉션뷰 연결
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.dataSource = self
//
//        //페이지네이션
//        mainView.collectionView.prefetchDataSource = self
//
//        //서치뷰 collectionView reloadData 처리
//        mainView.requestReloadDataHandler = {
//        self.mainView.collectionView.reloadData()
//        }
//
//
//    }
//
//
//
//
//    override func setConstraints() {}
//
//
//}
//
//
////서치바 (검색기능 구현)
//
//extension SearchViewController: UISearchBarDelegate {
//
//    //네트워크 통신 세팅
//    func searchQuery (query: String) {
////        searchQuery = query
//        searchList.items.removeAll()
//
//        SearchAPIManager.shared.callRequest(query: query, sort: sort, page: page, display: 30) { data in
//            self.searchList = data
//            self.mainView.collectionView.reloadData()
//        } failure: {
//            print("검색 안된다.")
//        }
//
//        mainView.collectionView.reloadData()
//    }
//
//    //검색버튼 클릭시 검색 진행
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        page = 1
//        searchList.items.removeAll()
//        guard let text = searchBar.text else { return }
//        searchQuery(query: text)
//    }
//
//    //취소버튼 클릭시
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchList.items.removeAll()
//        mainView.collectionView.reloadData()
//
//    }
//
//}
//
//
//// 좋아요버튼 딜리게이트 + Realm 구성 (저장 + 업데이트)
//
//extension SearchViewController : SearchCollectionViewCellDelegate {
//    func favoriteButtonTapped(for cell: SearchCollectionViewCell) {
//        guard let indexPath = mainView.collectionView.indexPath(for: cell) else {return}
//
//        let data = searchList.items[indexPath.row]
//        let task = Shopping(productImage: data.image, productName: data.title, storeName: data.mallName, price: data.lprice, webLink: data.link, favorite: data.like, date: Date(), productId: data.productID)
//
//        repository.createItem(task)
//
//
//
//    }
//
//
//}
//
//
////컬렉션뷰
//
//extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return searchList.items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//
//        //indexPath.row 설정
//        let data = searchList.items[indexPath.row]
//        let shoppingData = tasks[indexPath.row]
//        cell.data = shoppingData
//
//        //셀 설정
//        if let imageURL = URL(string: data.image!) {
//            cell.productImage.kf.setImage(with: imageURL)
//        }
//
//        let removeHTMLText = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) //검색어 특수문자 제거
//        cell.productNameLabel.text = removeHTMLText
//        cell.storeNameLabel.text = data.mallName
//        cell.priceLabel.text = data.lprice
//        cell.delegate = self
//
//        return cell
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //상세화면으로 넘어감
//    }
//
//}
//
//
////페이지네이션
//
//extension SearchViewController : UICollectionViewDataSourcePrefetching {
//
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//
//        for indexPath in indexPaths {
//            if searchList.items.count - 1 == indexPath.row && page < searchList.total && isEnd == false {
//                page += 1
//
//                if let query = mainView.searchbar.text {
//                    SearchAPIManager.shared.callRequest(query: query, sort: sort, page: page, display: display) { data in
//
//                        self.searchList.items.append(contentsOf: data.items)
//                        self.mainView.collectionView.reloadData()
//
//
//                    } failure: {
//                        print("페이지네이션 실패")
//                    }
//                }
//
//            }
//        }
//
//        print("===\(indexPaths)")
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        print("===취소: \(indexPaths)")
//
//    }
//
//
//
//}
////
///
///
/////
//  SearchCollectionViewCell.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//  <상품 검색> 컬렉션뷰셀 : 상품이미지, 가게명, 상품이름, 좋아요 버튼
//
//import UIKit
//import SnapKit
//import RealmSwift
//
//protocol SearchCollectionViewCellDelegate: AnyObject {
//    func favoriteButtonTapped(for cell: SearchCollectionViewCell)
//}
//
//
//class SearchCollectionViewCell: BaseCollectionViewCell {
//    
//    weak var delegate: SearchCollectionViewCellDelegate?
//    var data : Shopping?
//    let repository = ShoppingRepository()
//    var tapped : Bool = true
//    
//    let productImage = {
//        let view = UIImageView()
//        view.layer.cornerRadius = 20
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
//    
//    let likeButton = {
//        let view = UIButton()
//        view.layer.cornerRadius = 20
//        view.backgroundColor = .white
//        view.setImage(UIImage(systemName: "heart"), for: .normal)
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
//    
//    let storeNameLabel = {
//        let view = UILabel()
//        view.textColor = .systemGray
//        view.font = .systemFont(ofSize: 12)
//        return view
//    }()
//    let productNameLabel = {
//        let view = UILabel()
//        view.numberOfLines = 0
//        view.lineBreakMode = .byWordWrapping
//        view.textColor = .white
//        view.font = .systemFont(ofSize: 13)
//        return view
//    }()
//    let priceLabel = {
//        let view = UILabel()
//        view.textColor = .white
//        view.font = .boldSystemFont(ofSize: 18)
//        return view
//        
//    }()
//    
//    override func configureView() {
//        addSubview(productImage)
//        addSubview(likeButton)
//        addSubview(storeNameLabel)
//        addSubview(productNameLabel)
//        addSubview(priceLabel)
//        
//        repository.getFileURL()
//        repository.fetch()
//
//        likeButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
//    }
//    
//    
//    @objc func favoriteButtonTapped() {
//        
//        
//        guard let data = data else {return}
//        var favoriteState = data.favorite
//        
////        if data.favorite == true {
////            favoriteState = false
////        } else {
////            favoriteState = true
////        }
////        print(favoriteState)
////
//        if favoriteState == true {
//            likeButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
//            print(favoriteState, "좋아요 오케이~")
//        } else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//            print(favoriteState, "좋아요 해제!")
//        }
//        
//        print(data)
//        
//        repository.updateItem(id: data._id, like: data.favorite)
//        print(data.favorite, favoriteState)
//
//        delegate?.favoriteButtonTapped(for: self)
//        
//        
////        guard let data = data else {return}
////
////        tapped.toggle()
////        if tapped == true {
////            likeButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
////            print(tapped, "좋아요 오케이")
////            print(data, "좋아요 성공 시 나오나")
////        } else {
////            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
////            print(tapped, "좋아요 해제!")
////            print(data, "좋아요 실패 시 나오나")
////        }
////
////
////        delegate?.favoriteButtonTapped(for: self)
//        
//        //3안
////        data.favorite.toggle()
////
////        if data.favorite == true {
////            likeButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
////            print(data.favorite, "좋아요 오케이")
////            print(data, "나오나")
////        } else {
////            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
////            print(data.favorite, "좋아요 해제!")
////        }
////
////        delegate?.favoriteButtonTapped(for: self)
//        
//        //2안
////        guard let data = data else { return }
////        var favoriteState = data.favorite
////
////        if data.favorite == true {
////            favoriteState = false
////        } else {
////            favoriteState = true
////        }
////
////        print(favoriteState)
////
////        if favoriteState == true {
////            likeButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
////
////        } else {
////            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
////
////        }
//        
//        //1안
////        data.favorite.toggle()
////
////        if data.favorite {
////            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
////            print("좋아용", data.favorite)
////        } else {
////            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
////            print("좋아요 해제", data.favorite)
////        }
//        
////        delegate?.favoriteButtonTapped(for: self)
//        
//        
//    }
//    
//    
//    override func setConstraints() {
//        
//        productImage.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.6)
//        }
//        
//        likeButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-10)
//            make.bottom.equalTo(productImage.snp.bottom).inset(10)
//            make.size.equalTo(40)
//        }
//        
//        storeNameLabel.snp.makeConstraints { make in
//            make.top.equalTo(productImage.snp.bottom).offset(5)
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(20)
//        }
//        
//        productNameLabel.snp.makeConstraints { make in
//            make.top.equalTo(storeNameLabel.snp.bottom).offset(1)
//            make.horizontalEdges.equalToSuperview()
//            make.height.lessThanOrEqualTo(36)
//        }
//        
//        priceLabel.snp.makeConstraints { make in
//            make.top.equalTo(productNameLabel.snp.bottom).offset(1)
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(20)
//        }
//        
//        
//        
//
//        
//    }
//    
//    
//}
////
