//
//  SearchView.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit
import SnapKit
import RealmSwift


class SearchingView: BaseView {
                
    //컬렉션뷰
    var searchList : Search = Search(total: 0, start: 0, display: 0, items: [])
    

    
    // 컬렉션뷰 세팅
    lazy var collectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchingCollectionViewCell.self, forCellWithReuseIdentifier: "SearchingCollectionViewCell")
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
        let view = SearchbarCustom()
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return view
    }()
    
    //버튼 1~4
        
    let accuracyButton = { //정확도
        let view = FilterButtonCustom()
        view.setTitle("정확도", for: .normal)
        return view
    }()
    
    let dateButton = { //날짜순
        let view = FilterButtonCustom()
        view.setTitle("날짜순", for: .normal)
        return view
    }()
    
    let highPriceButton = { //가격높은순
        let view = FilterButtonCustom()
        view.setTitle("가격높은순", for: .normal)
        return view
    }()
    
    let lowPriceButton = { //가격낮은순
        let view = FilterButtonCustom()
        view.setTitle("가격낮은순", for: .normal)
        return view
    }()
    

    
    override func configureView() {
        
//        addSubview(searchbar)
        addSubview(accuracyButton)
        addSubview(dateButton)
        addSubview(highPriceButton)
        addSubview(lowPriceButton)
        addSubview(collectionView)
        collectionView.backgroundColor = .white

        
    }
    
    
    override func setConstraints() {
//        searchbar.snp.makeConstraints { make in
//            make.top.equalTo(self.safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(7)
//            make.height.equalTo(40)
//        }
        
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.height.equalTo(34)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(34)
        }
        highPriceButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(dateButton.snp.trailing).offset(5)
            make.width.equalTo(77)
            make.height.equalTo(34)
        }
        lowPriceButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(highPriceButton.snp.trailing).offset(5)
            make.width.equalTo(77)
            make.height.equalTo(34)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    
    
}
