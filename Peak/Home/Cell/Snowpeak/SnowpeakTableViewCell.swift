//
//  SnowpeakTableViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/28/23.
//

import UIKit

class SnowpeakTableViewCell: BaseTableViewCell {
    
    static let identifier = "SnowpeakTableViewCell"
    
    var snowpeakList: Search = Search(total: 0, start: 0, display: 0, items: []) //스노우피크
    
    let titleLabel = {
        let view = UILabel()
        view.font = ConstantFont.extrabd15
        view.textColor = .black
        view.text = "스노우피크"
        return view
    }()
    
    let SnowpeakCollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.showsHorizontalScrollIndicator = false
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing)
        
        layout.itemSize = CGSize(width: width / 3 , height: 190)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    override func configureView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(SnowpeakCollectionView)
        
        SnowpeakCollectionView.delegate = self
        SnowpeakCollectionView.dataSource = self
        
        networkForSnowpeak()
    }
    
    override func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(17)
        }
        SnowpeakCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func networkForSnowpeak() {
        
        NetworkManager.shared.callRequest(query: "스노우피크", sort: "sim", page: 1, display: 10) { data in
            self.snowpeakList = data
            self.SnowpeakCollectionView.reloadData()
        } failure: {
            print("md : 네트워크 실패!")
        }
    }
    
}


extension SnowpeakTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return snowpeakList.items.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let data = snowpeakList.items[indexPath.item]
        
        let value = Int(data.lprice)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: value) ?? data.lprice
        
        cell.priceNameLaebel.text = "\(result)원"
        
        let fixedTitle = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.productNameLabel.text = fixedTitle
        cell.productNameLabel.setLineSpacing(spacing: 1)
        
        if let url = URL(string: data.image!) {
            cell.productImage.kf.setImage(with: url)
        }
        return cell
        
    }
    
    
    
    
}
