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
        setupTabBarAppearance()
        configureApperance()
        
    }
    

    func configireTabBarController() {
        let firstVC = HomeViewController()
        firstVC.tabBarItem.title = "첫화면"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fil")
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        
        let secondVC = SerachViewController()
        secondVC.tabBarItem.title = "두번째 화면"
        secondVC.tabBarItem.image = UIImage(systemName: "trash")
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "trash.fil")
        
        setViewControllers([firstNav, secondVC], animated: true)
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
        navigationBarAppearance.backgroundColor = .red
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
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
