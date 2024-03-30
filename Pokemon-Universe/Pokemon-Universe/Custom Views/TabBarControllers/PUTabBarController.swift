//
//  PUTabBarController.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

final class PUTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemBlue // it effects whole tabbar
        viewControllers = [createHomeNC(), createFavoritesNC()]
        configureTabBarAppearance()
    }
    
    func createHomeNC() -> UINavigationController {
        let homeVM = HomeVM()
        let favoritesVC = HomeVC(viewModel: homeVM)
        favoritesVC.title = "Home"
        favoritesVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVM = FavoritesVM()
        let favoritesVC = FavoritesVC(viewModel: favoritesVM)
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = UIColor.systemBackground // for light mode
        appearance.configureWithDefaultBackground() // for dark mode
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
