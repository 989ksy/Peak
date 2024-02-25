//
//  HomeView.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/25/23.
//

import UIKit
import SnapKit

class HomeView : BaseView {
    
    lazy var homeTableView = {
        let view = UITableView()
        view.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.identifier)
        view.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        view.register(SnowpeakTableViewCell.self, forCellReuseIdentifier: SnowpeakTableViewCell.identifier)
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func configureView() {
        addSubview(homeTableView)
    }
    
    override func setConstraints() {
        homeTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}
