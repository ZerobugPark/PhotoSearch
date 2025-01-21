//
//  TabBarController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        configireTabBarController()
        //setupTabBarAppearance()
        configureApperance()
        self.selectedIndex = 1
    }
    

    func configireTabBarController() {
        let firstVC = HomeViewController()
        firstVC.tabBarItem.image = UIImage(systemName: "photo.on.rectangle")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "photo.fill.on.rectangle.fill")
        firstVC.tabBarController?.selectedIndex = 0
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        
        let secondVC = ShortsViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "video")
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "video.fill")
        secondVC.tabBarController?.selectedIndex = 1
        let secondNav = UINavigationController(rootViewController: secondVC)

        
        
        let thirdVC = SearchViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        thirdVC.tabBarController?.selectedIndex = 2
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        
        
        setViewControllers([firstNav, secondNav, thirdNav], animated: true)
  
    }
    
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .blue
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black

    }
    
    // 네비게이션 컨트롤러 및 탭바 공통 적용
    func configureApperance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        
        
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = .white
        
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
    }
    
    
}


extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
