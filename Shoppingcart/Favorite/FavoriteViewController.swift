//
//  FavoriteViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/08.
//  <좋아요 목록> 뷰컨트롤러
// let tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "date", ascending: false) 최근등록순~

import UIKit
import RealmSwift
import Kingfisher

class FavoriteViewController : BaseViewController {
    
    let mainView = FavoriteView()
    let repository = ShoppingRepository()
    let realm = try! Realm()
    
    var tasks : Results<Shopping>!
    
    override func loadView() {
        let view = mainView
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //추가 하자마자 바로 추가, Realm 불러오기, 내림차순 (제일 최신순)
            tasks = repository.fetch()
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
        
    }
    
    override func setConstraints() {}
    
    func update() {
        repository.fetch()
        mainView.collectionView.reloadData()
    }
    
    
}

extension FavoriteViewController: UISearchBarDelegate {
    
    func searchQuery (query: String) {

        mainView.collectionView.reloadData()
    }

//검색버튼 클릭시 검색 진행 (검색 query는 제품명만 가능)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text else { return }
        
        let result = realm.objects(Shopping.self).where {
            $0.productName.contains(query, options: .caseInsensitive)
        }
//        searchQuery(query: query)
        mainView.collectionView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = mainView.searchbar.text else {return}
        searchQuery(query: text)
    }

    
//취소버튼 클릭시 (등록된 모든 아이템 보여줌)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        mainView.collectionView.reloadData()
    }
    
    func tapTouched(_ sender: UITapGestureRecognizer) {
        mainView.endEditing(true)
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
    //가격
        cell.priceLabel.text = data.price
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = FavProductViewController()
        let shoppingData = tasks[indexPath.row]
        
        vc.shoppingData = shoppingData
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
