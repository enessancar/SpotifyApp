//
//  TabBarVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        viewControllers = [
            createNavController(for: HomeVC(), title: "Home", imageName: "house"),
            createNavController(for: SearchVC() , title: "Search", imageName: "magnifyingglass"),
            createNavController(for: LibraryVC(), title: "Library", imageName: "music.note.list")
        ]
    }
    
    fileprivate func createNavController(for viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .systemBackground
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
}

