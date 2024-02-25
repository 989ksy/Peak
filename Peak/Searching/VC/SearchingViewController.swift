//
//  SearchViewController.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit
import SnapKit
import Kingfisher
import RealmSwift

class SearchingViewController: BaseViewController {
    
    let mainView = SearchingView()
    let viewModel = SearchingViewModel()
    
    var searchWord: String? //검색어 자동입력어
    
    var buttonArray = [UIButton]()
    
    override func loadView() {
        let view = mainView
        self.view = view
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //정렬 버튼 액션_ 디폴트 설정
        defaultButtonIsTapped()
        
        //버튼
        AppendingCityButtonArray()
        
        for button in buttonArray {
            button.addTarget(self, action: #selector(selectedButtonAction), for: .touchUpInside)
        }
        
        cityButtonAction()
        
        //서치바
        
        self.navigationItem.titleView = mainView.searchbar
        
        //키보드 숨김
        hideKeyboardWhenTappedAround()
        
        //이전 화면에서 태그 눌렀을 때
        //태그 단어가 있으면 서치바에 나타내기
        //서치바에 단어 있으면 바로 정확도 기준으로 검색
        mainView.searchbar.text = searchWord
        searchingWord()
        
        
    }
    
    
    override func configureView() {
        super.configureView()
        
        viewModel.tasks = viewModel.repository.fetch()
        
        //네비게이션 영역
        title = "검색"
        navigationController?.navigationBar.barTintColor = ConstantColor.Green
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        //서치바
        mainView.searchbar.delegate = self
        
        //컬렉션뷰 연결
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        //페이지네이션
        mainView.collectionView.prefetchDataSource = self
        
    }
    
    //MARK: - 이전 화면 단어 받아서 검색
    
    func searchingWord() {
        if mainView.searchbar.text != nil {
            NetworkManager.shared.callRequest(query: searchWord ?? "", sort: "sim", page: viewModel.start, display: viewModel.display) { data in
                self.mainView.searchList = data
                self.mainView.collectionView.reloadData()
            } failure: {
                print("오류")
            }
            
        }
    }
    
    ///서치했을 때 정확도가 디폴트로 눌려있게.
    func defaultButtonIsTapped(){
        if mainView.searchbar.text != nil {
            mainView.accuracyButton.isSelected = true
            mainView.accuracyButton.backgroundColor = ConstantColor.Green
            mainView.accuracyButton.setTitleColor(.white, for: .normal)
        }
    }
    
    //MARK: - 필터 버튼
    
    ///ButtonArray에 담음
    func AppendingCityButtonArray() {
        buttonArray.append(mainView.accuracyButton)
        buttonArray.append(mainView.dateButton)
        buttonArray.append(mainView.highPriceButton)
        buttonArray.append(mainView.lowPriceButton)
    }
    
    ///선택한 버튼 UI
    @objc func selectedButtonAction(_ sender: UIButton) {
        for btn in buttonArray {
            if btn == sender {
                btn.isSelected = true
                btn.layer.backgroundColor = ConstantColor.Green?.cgColor
                btn.titleLabel?.font = ConstantFont.reg14
                btn.setTitleColor(.white, for: .normal)
                
            } else {
                btn.isSelected = false
                btn.backgroundColor = .clear
                btn.layer.borderColor = UIColor.systemGray2.cgColor
                btn.setTitleColor(.lightGray, for: .normal)
                btn.titleLabel?.font = ConstantFont.reg14
            }
        }
    }
    
    func cityButtonAction() {
        
        mainView.accuracyButton
            .addTarget(self,
                       action: #selector(accuracyButtonTapped),
                       for: .touchUpInside
            )
        mainView.dateButton
            .addTarget(self,
                       action: #selector(dateButtonTapped),
                       for: .touchUpInside
            )
        mainView.highPriceButton
            .addTarget(self,
                       action: #selector(highPriceButtonTapped),
                       for: .touchUpInside
            )
        mainView.lowPriceButton
            .addTarget(self,
                       action: #selector(lowPriceButtonTapped),
                       for: .touchUpInside
            )
    }
    
    //정확도순으로 보기
    @objc func accuracyButtonTapped() {
        let queryText = mainView.searchbar.text ?? ""
        
        NetworkManager.shared.callRequest(query: queryText, sort: "sim", page: viewModel.start, display: viewModel.display) { data in
            self.mainView.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 정확성 API")
        } failure: {
            print("정확성 오류")
        }
    }
    
    //날짜순으로 보기
    @objc func dateButtonTapped() {
        
        let queryText = mainView.searchbar.text ?? ""
        
        NetworkManager.shared.callRequest(query: queryText, sort: "date", page: viewModel.start, display: viewModel.display) { data in
            self.mainView.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 정확성 API")
        } failure: {
            print("정확성 오류")
        }
        
    }
    
    //가격높은순으로 보기
    @objc func highPriceButtonTapped() {
        let queryText = mainView.searchbar.text ?? ""
        // API 호출
        NetworkManager.shared.callRequest(query: queryText, sort: "dsc", page: viewModel.start, display: viewModel.display) { data in
            self.mainView.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 가격높은 순 API")
        } failure: {
            print("가격 높은 순 오류")
        }
        
    }
    
    //가격낮은순으로 보기
    @objc func lowPriceButtonTapped() {
        
        let queryText = mainView.searchbar.text ?? ""
        
        // API 호출
        NetworkManager.shared.callRequest(query: queryText, sort: "asc", page: viewModel.start, display: viewModel.display) { data in
            self.mainView.searchList = data
            self.mainView.collectionView.reloadData()
            print("==== 가격높은 순 API")
        } failure: {
            print("가격 높은 순 오류")
        }
        
    }
    
    
    //MARK: - 좋아요 구현
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        print("=== 버튼 눌림1: \(#function)")
        
        let indexPath = sender.tag
        
        guard let cell = mainView.collectionView.cellForItem(at: IndexPath(item: indexPath, section: 0)) as? SearchingCollectionViewCell else {return}
        print("=== 버튼 눌림2, 인덱스:\(indexPath)")
        
        var data = mainView.searchList.items[indexPath] //코더블 식판
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
            viewModel.repository.createItem(task)
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
        
        mainView.searchList.items[sender.tag].like.toggle()
        
        var favoriteState = mainView.searchList.items[sender.tag].like
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


//MARK: - 서치바

extension SearchingViewController: UISearchBarDelegate {
    
    //네트워크 통신 세팅
    func searchQuery (query: String) {
        mainView.searchList.items.removeAll()
        
        NetworkManager.shared.callRequest(query: query, sort: viewModel.sort, page: viewModel.page, display: 30) { data in
            self.mainView.searchList = data
            self.mainView.collectionView.reloadData()
        } failure: {
            print("검색 안된다.")
        }
        
        mainView.collectionView.reloadData()
    }
    
    //검색버튼 클릭시 검색 진행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.page = 1
        mainView.searchList.items.removeAll()
        guard let text = searchBar.text else { return }
        searchQuery(query: text)
        
    }
    
    //취소버튼 클릭시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        mainView.searchList.items.removeAll()
        mainView.collectionView.reloadData()
        
        
    }
    
}



//MARK: - 컬렉션뷰

extension SearchingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.searchList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchingCollectionViewCell", for: indexPath) as? SearchingCollectionViewCell else { return UICollectionViewCell() }
        
        //indexPath.row 설정
        let data = mainView.searchList.items[indexPath.row]
        let dataImage = data.image!
        
        //셀 설정
        //제품사진
        if let imageURL = URL(string: dataImage) {
            cell.productImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(),
                options: [
                    .processor(DownsamplingImageProcessor(
                            size: CGSize(width: 250, height: 250)
                        )),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
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
        cell.priceLabel.text = "\(result)원"
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
        
        let data = mainView.searchList.items[indexPath.row]
        vc.sharedData = data
        
    }
    
}


//MARK: - 페이지네이션

extension SearchingViewController : UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if mainView.searchList.items.count - 1 == indexPath.row && viewModel.page < mainView.searchList.total && viewModel.isEnd == false {
                viewModel.page += 1
                
                if let query = mainView.searchbar.text {
                    NetworkManager.shared.callRequest(query: viewModel.query, sort: viewModel.sort, page: viewModel.page, display: viewModel.display) { data in
                        
                        self.mainView.searchList.items.append(contentsOf: data.items)
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
