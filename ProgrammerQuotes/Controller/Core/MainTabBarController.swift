//
//  MainTabBarController.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 17.10.2022.
//
import UIKit
final class MainTabBarController: UITabBarController {
    private let homeVM = HomeViewModel()
    private lazy var favoritesVM = FavoritesViewModel(homeVM: homeVM)
    private lazy var vc1 = UINavigationController(rootViewController: HomeViewController(homeVM: homeVM))
    private lazy var vc2 = UINavigationController(rootViewController: FavoritesViewController(favoritesVM: favoritesVM))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Favorites"
        
        tabBar.tintColor = UIColor.mainColor
        setViewControllers([vc1,vc2], animated: true)
    }
}
