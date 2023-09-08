//
//  SearchView.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.

// 쇼핑검색 컬렉션뷰 색상 바꾸는 것 잊지 말자.

import UIKit
import SnapKit

class SearchView: BaseView {
    
//    weak var delegate: SearchViewProtocol?
    
    var buttonTapped = false
    
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
    
    
    //뷰 객체
    
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
        
        accuracyButton.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(lowPriceButtonTapped), for: .touchUpInside)
        
    }
    
    
    
    @objc func accuracyButtonTapped() {
        buttonTapped.toggle()
        
        if buttonTapped {
            accuracyButton.backgroundColor = .white
            accuracyButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            accuracyButton.backgroundColor = .black
            accuracyButton.setTitleColor(UIColor.white, for: .normal)
        }
        print("정확 버튼")
        
        
    }
    
    @objc func dateButtonTapped() {
        buttonTapped.toggle()
        
        if buttonTapped {
            dateButton.backgroundColor = .white
            dateButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            dateButton.backgroundColor = .black
            dateButton.setTitleColor(UIColor.white, for: .normal)
        }
        print("날짜 버튼")
        
    }
    
    @objc func highPriceButtonTapped() {
        buttonTapped.toggle()
        
        if buttonTapped {
            highPriceButton.backgroundColor = .white
            highPriceButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            highPriceButton.backgroundColor = .black
            highPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
        print("비쌈 버튼")
        
    }
    
    @objc func lowPriceButtonTapped() {
        buttonTapped.toggle()
        
        if buttonTapped {
            lowPriceButton.backgroundColor = .white
            lowPriceButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            lowPriceButton.backgroundColor = .black
            lowPriceButton.setTitleColor(UIColor.white, for: .normal)
        }
        print("쌈 버튼")
        
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


//extension SearchView : UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//
//        return cell
//
//    }
//
//}
