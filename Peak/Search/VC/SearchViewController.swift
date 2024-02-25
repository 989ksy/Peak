//
//  SearchViewController.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/26/23.
//

import UIKit
import SnapKit


class SearchViewController : BaseViewController {
    
    let mainView = SearchView()
    let recommendList = RecommendText()
    let searchList = HotWordList()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        self.title = "검색"
        self.navigationItem.titleView = mainView.searchBar
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = ConstantColor.Green
        
        //기본 화면 세팅
        
        let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = .white
                    appearance.shadowColor = .clear
                    appearance.shadowImage = UIImage()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        mainView.recommendCollectionView.dataSource = self
        mainView.recommendCollectionView.delegate = self
        mainView.hotSearchTableView.delegate = self
        mainView.hotSearchTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.searchBar.text = ""
        mainView.searchBar.placeholder = "검색어 입력"
        let isEmpty = mainView.searchBar.text?.isEmpty ?? true
    }
    
}


//MARK: - 컬렉션뷰_ 태그

extension SearchViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as? RecommendationCell else { return UICollectionViewCell() }
        
        let recommendItem = recommendList.list[indexPath.item]
        cell.wordLabel.text = recommendItem.text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? RecommendationCell else { return }
        
        let selectedText = cell.wordLabel.text ?? ""
        mainView.searchBar.text = selectedText
        
        let vc = SearchingViewController()
        vc.searchWord = selectedText
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    // 셀 크기설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            
            let label = UILabel()
            
            label.font = ConstantFont.bd14
            label.text = recommendList.list[indexPath.item].text
            label.sizeToFit()
            
            return label
        }()
        
        let size = label.frame.size
        
        return CGSize(width: size.width + 20, height: size.height + 20)
    }
}


//MARK: - 테이블뷰_ 실시간 인기검색어

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotSearchTableViewCell", for: indexPath) as? HotSearchTableViewCell else { return UITableViewCell() }
        
        let searchItem = searchList.list[indexPath.item]
        cell.rankingLabel.text = "\(indexPath.row + 1)"
        cell.itemLabel.text = searchItem.text
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    
    
}
