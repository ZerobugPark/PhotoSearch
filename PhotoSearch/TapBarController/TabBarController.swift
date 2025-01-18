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
        //firstVC.tabBarItem.title = "첫화면"
        firstVC.tabBarItem.image = UIImage(systemName: "photo.on.rectangle")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "photo.fill.on.rectangle.fill")
        firstVC.tabBarController?.selectedIndex = 0
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        
        let secondVC = SerachViewController()
        //secondVC.tabBarItem.title = "두번째 화면"
        secondVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        secondVC.tabBarController?.selectedIndex = 1
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        setViewControllers([firstNav, secondNav], animated: true)
  
    }
    
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .blue
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black

    }
    
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
        print(item)
    }
}
