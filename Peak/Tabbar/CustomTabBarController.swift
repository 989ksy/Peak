//
//  CustomTabBarController.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //기본 컬러세팅
        self.tabBar.tintColor = ConstantColor.Green //눌림 아이콘 컬러
        self.tabBar.unselectedItemTintColor = .lightGray //안눌림 아이콘 컬러
        self.tabBar.isTranslucent = false //불투명 X
        self.tabBar.backgroundColor = .white //백그라운드 : 하얀색
        
    //아이콘 설정
        
        let mainVC = UINavigationController(rootViewController: HomeViewControlelr())
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        mainVC.tabBarItem.title = "홈"
        
        let firstVC = UINavigationController(rootViewController: SearchViewController())
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        firstVC.tabBarItem.title = "검색"
        firstVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let SecondVC = UINavigationController(rootViewController: FavoriteViewController())
        SecondVC.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        SecondVC.tabBarItem.title = "좋아요"
        SecondVC.tabBarItem.image = UIImage(systemName: "heart")

        viewControllers = [mainVC, firstVC, SecondVC]
        
    }

}
