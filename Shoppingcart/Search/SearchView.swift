//
//  SearchView.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.

//<상품 검색> 뷰 : 컬렉션뷰, 검색바, 정렬버튼
// 쇼핑검색 컬렉션뷰 색상 바꾸는 것 잊지 말자.

import UIKit
import SnapKit
import RealmSwift


class SearchView: BaseView {
            
    var buttonTapped = false
    let repository = ShoppingRepository()
    
    var dataSource: Results<Shopping>?
    
    //정렬
    var query = "캠핑"
    var display = 30
    var start = 1
    var sort = "sim" //기본값
    
    //컬렉션뷰
    var searchList : Search = Search(total: 0, start: 0, display: 0, items: [])
    var requestReloadDataHandler: (() -> Void)?
    
    

    
    // 컬렉션뷰 세팅
    lazy var collectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        return view
    }()

    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) //양 끝쪽 여백
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size/2, height: size/1.5)
        return layout

    }
    
    
    //검색바
    
    let searchbar = {
        let view = UISearchBar()
        view.barTintColor = .clear
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "상품을 검색해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray4])
        view.searchTextField.leftView?.tintColor = .white
        view.searchTextField.textColor = .white
        view.searchTextField.backgroundColor = .darkGray
        view.tintColor = .white
        view.showsCancelButton = true
        return view
    }()
    
    //버튼 1~4
    let accuracyButton = { //정확도
        let view = UIButton()
        view.setTitle("정확도", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let dateButton = { //날짜순
        let view = UIButton()
        view.setTitle("날짜순", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let highPriceButton = { //가격높은순
        let view = UIButton()
        view.setTitle("가격높은순", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let lowPriceButton = { //가격낮은순
        let view = UIButton()
        view.setTitle("가격낮은순", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    

    
    override func configureView() {
        
        addSubview(searchbar)
        addSubview(accuracyButton)
        addSubview(dateButton)
        addSubview(highPriceButton)
        addSubview(lowPriceButton)
        addSubview(collectionView)
        collectionView.backgroundColor = .black
        
        //버튼 액션
        accuracyButton.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(lowPriceButtonTapped), for: .touchUpInside)
        
    }
    
    
    //정확도로 보기
    @objc func accuracyButtonTapped() {
        buttonTapped.toggle()
        
        let queryText = self.searchbar.text ?? ""
        let querySort = buttonTapped ? "sim" : "sim"
        
        if buttonTapped {
            accuracyButton.backgroundColor = .white
            accuracyButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            accuracyButton.backgroundColor = .black
            accuracyButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
//            self.searchList.items.append(contentsOf: data.items)
            self.collectionView.reloadData()
            print("==== 정확성 API")
        } failure: {
            print("정확성 오류")
        }
        
        print(buttonTapped ? "정확성 눌림" : "정확성 해제")
        
        
        
    }
    
    //날짜순으로보기
    @objc func dateButtonTapped() {
        
        buttonTapped.toggle()
        
        let queryText = self.searchbar.text ?? ""
        let querySort = buttonTapped ? "date" : "sim"
        
        if buttonTapped {
            dateButton.backgroundColor = .white
            dateButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            dateButton.backgroundColor = .black
            dateButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
            self.requestReloadDataHandler?()
//            self.searchList.items.append(contentsOf: data.items)
//            self.collectionView.reloadData()
            print("==== 날짜순 API")
        } failure: {
            print("날짜순 오류")
        }
        
        print(buttonTapped ? "날짜순 눌림" : "날짜순 해제")
        
    }
    
    //가격높은순으로 보기
    @objc func highPriceButtonTapped() {
        
        buttonTapped.toggle()
        
        let queryText = self.searchbar.text ?? ""
        let querySort = buttonTapped ? "dsc" : "sim"
            
        if buttonTapped {
            highPriceButton.backgroundColor = .white
            highPriceButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            highPriceButton.backgroundColor = .black
            highPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
            
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
//            self.searchList.items.append(contentsOf: data.items)
            self.collectionView.reloadData()
            print("==== 가격높은 순 API")
        } failure: {
            print("가격 높은 순 오류")
        }
            
        print(buttonTapped ? "비쌈 버튼 눌림" : "비쌈 버튼 해제")
        

        
    }
    
    //가격낮은순으로 보기
    @objc func lowPriceButtonTapped() {
        buttonTapped.toggle()
        
        
        let queryText = self.searchbar.text ?? ""
        let querySort = buttonTapped ? "asc" : "sim"
            
        if buttonTapped {
            lowPriceButton.backgroundColor = .white
            lowPriceButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            lowPriceButton.backgroundColor = .black
            lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
            
        // API 호출
        SearchAPIManager.shared.callRequest(query: queryText, sort: querySort, page: start, display: display) { data in
            self.searchList = data
//            self.searchList.items.append(contentsOf: data.items)
            self.collectionView.reloadData()
            print("==== 가격높은 순 API")
        } failure: {
            print("가격 높은 순 오류")
        }
            
        print(buttonTapped ? "비쌈 버튼 눌림" : "비쌈 버튼 해제")
        

    }
    
    
    
    override func setConstraints() {
        searchbar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(43)
            make.height.equalTo(30)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(10)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(5)
            make.width.equalTo(43)
            make.height.equalTo(30)
        }
        highPriceButton.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(10)
            make.leading.equalTo(dateButton.snp.trailing).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        lowPriceButton.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(10)
            make.leading.equalTo(highPriceButton.snp.trailing).offset(5)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    
    
}
