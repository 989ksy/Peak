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
    
    var data : Item? //코더블 객체(API)
    var shoppingData : Shopping? //렘모델
    
    
//페이지네이션 + 검색 + 정렬
    var page = 1 //start, 페이지네이션
    var total = 0 // 페이지네이션
    
    var sort = "sim" //기본값, 페이지네이션 & 정렬
    var display = 30 // 페이지네이션 & 정렬
    var isEnd = false //페이지네이션
    
    var buttonTapped = false //버튼 토글
    var start = 1 // 정렬
    var query = "캠핑" // 정렬
    
    
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
        
    //정렬 버튼 액션
        mainView.accuracyButton.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        mainView.highPriceButton.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        mainView.lowPriceButton.addTarget(self, action: #selector(lowPriceButtonTapped), for: .touchUpInside)
        
        //
        
    }
    
    
//정렬버튼
    
    //정확도로 보기
    @objc func accuracyButtonTapped() {
        
        buttonTapped.toggle()
        
        let queryText = mainView.searchbar.text ?? ""
        let querySort = buttonTapped ? "sim" : "sim"
        
        //버튼 조정
        if buttonTapped { //처음 눌렀을 때
            mainView.accuracyButton.isSelected = true
            mainView.dateButton.isSelected = false
            mainView.highPriceButton.isSelected = false
            mainView.lowPriceButton.isSelected = false

            mainView.accuracyButton.backgroundColor = .white
            mainView.accuracyButton.setTitleColor(UIColor.black, for: .normal)
            
            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        } else { // 다시 탭 했을 때
            mainView.accuracyButton.isSelected = false
            mainView.dateButton.isSelected = false
            mainView.highPriceButton.isSelected = false
            mainView.lowPriceButton.isSelected = false

            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            
            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        // API 호출
        
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 정확성 API")
        } failure: {
            print("정확성 오류")
            
        }
        
        print(buttonTapped ? "정확성 눌림" : "정확성 해제")
        
    }
    
    //날짜순으로보기
    @objc func dateButtonTapped() {
        
        buttonTapped.toggle()
        
        let queryText = mainView.searchbar.text ?? ""
        let querySort = buttonTapped ? "date" : "sim"
        
        //버튼 조정
        if buttonTapped {
            mainView.dateButton.isSelected = true
            mainView.accuracyButton.isSelected = false
            mainView.highPriceButton.isSelected = false
            mainView.lowPriceButton.isSelected = false

            mainView.dateButton.backgroundColor = .white
            mainView.dateButton.setTitleColor(UIColor.black, for: .normal)
            
            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            mainView.dateButton.isSelected = false
            mainView.accuracyButton.isSelected = false
            mainView.highPriceButton.isSelected = false
            mainView.lowPriceButton.isSelected = false

            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            
            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 날짜순 API")
        } failure: {
            print("날짜순 오류")
        }
        
        print(buttonTapped ? "날짜순 눌림" : "날짜순 해제")
        
    }
    
    
    //가격높은순으로 보기
    @objc func highPriceButtonTapped() {
        
        buttonTapped.toggle()
        
        let queryText = mainView.searchbar.text ?? ""
        let querySort = buttonTapped ? "dsc" : "sim"
        
        //버튼 조정
        if buttonTapped {
            mainView.highPriceButton.isSelected = true
            mainView.accuracyButton.isSelected = false
            mainView.dateButton.isSelected = false
            mainView.lowPriceButton.isSelected = false

            mainView.highPriceButton.backgroundColor = .white
            mainView.highPriceButton.setTitleColor(UIColor.black, for: .normal)
            
            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            mainView.highPriceButton.isSelected = false
            mainView.accuracyButton.isSelected = false
            mainView.dateButton.isSelected = false
            mainView.lowPriceButton.isSelected = false

            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
            
            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
            
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 가격높은 순 API")
        } failure: {
            print("가격 높은 순 오류")
        }
        
        print(buttonTapped ? "비쌈 버튼 눌림" : "비쌈 버튼 해제")
        

        
    }
    
    //가격낮은순으로 보기
    @objc func lowPriceButtonTapped() {
        
        buttonTapped.toggle()
        
        let queryText = mainView.searchbar.text ?? ""
        let querySort = buttonTapped ? "asc" : "sim"
        
        //버튼 조정
        if buttonTapped {
            mainView.lowPriceButton.isSelected = true
            mainView.accuracyButton.isSelected = false
            mainView.dateButton.isSelected = false
            mainView.highPriceButton.isSelected = false

            mainView.lowPriceButton.backgroundColor = .white
            mainView.lowPriceButton.setTitleColor(UIColor.black, for: .normal)
            
            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            mainView.lowPriceButton.isSelected = true
            mainView.accuracyButton.isSelected = false
            mainView.dateButton.isSelected = false
            mainView.highPriceButton.isSelected = false

            mainView.lowPriceButton.backgroundColor = .black
            mainView.lowPriceButton.setTitleColor(UIColor.white, for: .normal)
            
            mainView.accuracyButton.backgroundColor = .black
            mainView.accuracyButton.setTitleColor(UIColor.white, for: .normal)
            mainView.dateButton.backgroundColor = .black
            mainView.dateButton.setTitleColor(UIColor.white, for: .normal)
            mainView.highPriceButton.backgroundColor = .black
            mainView.highPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 가격높은 순 API")
        } failure: {
            print("가격 높은 순 오류")
        }
        
        print(buttonTapped ? "비쌈 버튼 눌림" : "비쌈 버튼 해제")
        
    }
    
    
    override func setConstraints() {}
    
//좋아요 버튼 구현 (저장, 삭제, 토글)
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        print("=== 버튼 눌림1: \(#function)")
        
        let indexPath = sender.tag
        
        guard let cell = mainView.collectionView.cellForItem(at: IndexPath(item: indexPath, section: 0)) as? SearchCollectionViewCell else {return}
        print("=== 버튼 눌림2, 인덱스:\(indexPath)")
                
        var data = searchList.items[indexPath] //코더블 식판
        print("=== 버튼 눌림3, 데이터 불러와봄: \(data)")
        
        //데이터가 저장 되어있는지 확인 (제품ID 기준)
        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productID
        }
        
        print("=== 버튼 눌림4, 데이터 저장 되었는지 확인 중")
        
        if isSavedData.isEmpty == true {
            // 좋아요 버튼 클릭 시 데이터 저장 (realm create)
            let task = Shopping(productImage: data.image, productName: data.title, storeName: data.mallName, price: data.lprice, webLink: data.link, favorite: true, date: Date(), productId: data.productID)
                repository.createItem(task)
            print("=== 버튼 눌림4-1, 데이터 저장 성공")
    
        } else {
            // 데이터가 있을 시 데이터 삭제 (realm delete)
            
            let deletingData = realm.objects(Shopping.self).where {
                $0.productId == data.productID }.first
            
            do {
                try realm.write {
                    realm.delete(deletingData!)
                print("=== 버튼 눌림4-2, 데이터 삭제 성공")
                }
            } catch {
                print ("=== 버튼 눌림4-2, 데이터 삭제 안되었음")
            }
            
        }
        
    //좋아요 버튼 상태
        
        searchList.items[sender.tag].like.toggle()
        
        var favoriteState = searchList.items[sender.tag].like
        print("====버튼눌림5, 1==초기설정값:\(favoriteState)")
        
        if favoriteState {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("====버튼눌림6-1, 2==, 필하트 설정값:\(favoriteState)")
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            print("====버튼눌림6-2, 3==, 빈하트 설정값:\(favoriteState)")
        }
        
        print("============== 서치뷰 좋아요 버튼 액션 끝!")
        
    }
    
    
    
}//


//서치바 (검색기능 구현)
extension SearchViewController: UISearchBarDelegate {
    
//네트워크 통신 세팅
    func searchQuery (query: String) {
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
        hideKeyboardWhenTappedBackground()
    }
    
//취소버튼 클릭시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchList.items.removeAll()
        mainView.collectionView.reloadData()
        hideKeyboardWhenTappedBackground()

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
        
    //셀 설정
        //제품사진
        if let imageURL = URL(string: data.image!) {
            cell.productImage.kf.setImage(with: imageURL)
        }
        //제품명
        let removeHTMLText = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) //검색어 특수문자 제거
        cell.productNameLabel.text = removeHTMLText
        //가게명
        cell.storeNameLabel.text = data.mallName
        //가격 (string -> Int, 소수점 표현)
        let value = Int(data.lprice)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: value! as NSNumber) ?? data.lprice
        cell.priceLabel.text = result
//        cell.priceLabel.text = data.lprice
        //좋아요버튼
        cell.likeButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        
        //productID를 이용해서 하트 저장하기
        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productID
        }
        
        if isSavedData.isEmpty == true {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
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
