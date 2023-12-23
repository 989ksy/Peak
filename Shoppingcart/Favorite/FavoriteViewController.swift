//
//  FavoriteViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/08.
//  <좋아요 목록> 뷰컨트롤러

import UIKit
import RealmSwift
import Kingfisher

class FavoriteViewController : BaseViewController {
    
    let mainView = FavoriteView()
    let repository = ShoppingRepository()
    let realm = try! Realm()
    
    var tasks : Results<Shopping>! //realm 테이블 데이터 (저장됨)
    var codableData : Item? //코더블 객체

    
    override func loadView() {
        let view = mainView
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //추가 하자마자 바로 추가, Realm 불러오기, 내림차순 (제일 최신순)
        tasks = repository.fetch()
        mainView.collectionView.reloadData()
        
    }
    
    override func configureView() {
        super.configureView()
        
    //기본 화면 세팅
        title = "좋아요 목록" //네비게이션 제목
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white] //네비게이션 폰트 색
        
    //컬렉션뷰 연결
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    //서치바 연결
        mainView.searchbar.delegate = self
        
    //Realm 불러오기, 내림차순 (제일 최신순)
        tasks = repository.fetch()
    
    //실시간 업데이트
        update()
    
    //키보드
        hideKeyboardWhenTappedAround()

    }
    
    override func setConstraints() {}
    
//추가하자마자 목록에 보여줌
    @objc func update() {
        repository.fetch()
        mainView.collectionView.reloadData()
    }
    

//즐겨찾기 목록 좋아요 버튼
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        print("=== 좋아요 목록 셀 버튼 눌림1: \(#function)")
        
        let indexPath = sender.tag //셀
        guard let cell = mainView.collectionView.cellForItem(at: IndexPath(item: indexPath, section: 0)) as? SearchCollectionViewCell else {return}
        print("=== 버튼 눌림2, 인덱스:\(indexPath)")
    
        let data = tasks[indexPath]
        
        //데이터 저장되었는지 확인하기 (productID 기준)
        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productId
        }
        
        print("여기까지 나옴?")
        
        if isSavedData.isEmpty == true {
            print("=== 데이터 저장은 이미 되어 있는 거니까, 이거 나오면 좀 이상할듯")
        } else {
            //데이터가 있을 시 데이터 삭제 (realm delete)
            
            let deletingData = realm.objects(Shopping.self).where {
                $0.productId == data.productId }.first
            do {
                try realm.write {
                    realm.delete(deletingData!)
                    print("=== 좋아요 목록 데이터 삭제 성공")
                }
            } catch {
                print("=== 데이터 삭제 X")
            }
        }
        
        mainView.collectionView.reloadData()

    }
    
}//


extension FavoriteViewController: UISearchBarDelegate {
    
    func searchQuery (query: String) {
        if query.isEmpty == true {
            tasks = repository.fetch()
        } else {
            tasks = repository.fetchProductNameFilter(productName: query)
        }
        mainView.collectionView.reloadData()
    }

//검색버튼 클릭시 검색 진행 (검색 query는 제품명만 가능)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        searchQuery(query: query)

    }

//실시간 검색기능
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = mainView.searchbar.text else {return}
        searchQuery(query: text)

    }

    
//취소버튼 클릭시 (등록된 모든 아이템 보여줌) *
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tasks = repository.fetch()
        mainView.collectionView.reloadData()
//        searchBar.resignFirstResponder()

    }

    
}




extension FavoriteViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        
        let data = tasks[indexPath.row]
        
    //이미지
        if let imageURL = URL(string: data.productImage!){
            cell.productImage.kf.setImage(with: imageURL)
        }
    //제품명
        let fixedTitle = data.productName.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.productNameLabel.text = fixedTitle
    //가게명
        cell.storeNameLabel.text = data.storeName
    //가격 (string -> Int, 소수점 표현)
        let value = Int(data.price)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: value) ?? data.price
        cell.priceLabel.text = result
            
    //좋아요 버튼 이미지 설정
        cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.likeButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = FavProductViewController()
        let shoppingData = tasks[indexPath.row] //쇼핑 realm 데이터
//        let codableData = codableData[indexPath.row] //빈값..ㅎ..
//        vc.codableData = codableData
        vc.shoppingData = shoppingData
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
