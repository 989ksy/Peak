//
//  CustomTabbarController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/09.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //기본 컬러세팅
        self.tabBar.tintColor = .white //눌림 아이콘 컬러
        self.tabBar.unselectedItemTintColor = .darkGray //안눌림 아이콘 컬러
        self.tabBar.isTranslucent = false //불투명 X
        self.tabBar.backgroundColor = .black //백그라운드 : 검정색
//        self.tabBar.scrollEdgeAppearance =
        
    //아이콘 설정
        let firstVC = UINavigationController(rootViewController: SearchViewController())
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        firstVC.tabBarItem.title = "검색"
        firstVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let SecondVC = UINavigationController(rootViewController: FavoriteViewController())
        SecondVC.tabBarItem.selectedImage = UIImage(systemName: "heart")
        SecondVC.tabBarItem.title = "좋아요"
        SecondVC.tabBarItem.image = UIImage(systemName: "heart")

        viewControllers = [firstVC, SecondVC]
        
    }


}
