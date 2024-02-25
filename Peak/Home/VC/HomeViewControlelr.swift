//
//  HomeViewControlelr.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/24/23.
//

import UIKit

class HomeViewControlelr : BaseViewController {
    
    let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.homeTableView.dataSource = self
        mainView.homeTableView.delegate = self
        
        mainView.homeTableView.rowHeight = UITableView.automaticDimension
        mainView.homeTableView.estimatedRowHeight = 20
        
        //로고설정
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        imageView.contentMode = .scaleAspectFit
           let image = UIImage(named: "Peak")
           imageView.image = image
           navigationItem.titleView = imageView
        
        
        //네비게이션바 설정
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = ConstantColor.Green
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notificationItemTapped))
        
        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc
    func notificationItemTapped() {
        
    }
    
    
    
}

extension HomeViewControlelr : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else if indexPath.section == 1 {
            
            return 320
            
        } else{
            return 250
        }
                
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell else { return UITableViewCell() }
            return cell
            
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
                        
            return cell
            
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SnowpeakTableViewCell.identifier, for: indexPath) as? SnowpeakTableViewCell else { return UITableViewCell() }
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
}

