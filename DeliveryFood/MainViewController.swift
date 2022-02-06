//
//  MainViewController.swift
//  DeliveryFood
//
//  Created by Олег Федоров on 05.02.2022.
//

import UIKit

private let cellID = "Cell"

class MainViewController: UITabBarController {
    
    var assembly: AssemblyProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assembly = Assembly()
        setupTabBar()
        setupViews()
    }
    
    private func setupViews() {
        guard let foodListVC = assembly?.createFoodListModule() else { return }
        let contactsVC = ContactsViewController()
        let profileVC = ProfileViewController()
        let basketVC = BasketViewController()
        
        foodListVC.setTabBarImage(imageName: "menucard", title: "Menu")
        contactsVC.setTabBarImage(imageName: "map.fill", title: "Contacts")
        profileVC.setTabBarImage(imageName: "person.fill", title: "Profile")
        basketVC.setTabBarImage(imageName: "arrow.up.bin.fill", title: "Basket")
        
        let foodListNC = UINavigationController(rootViewController: foodListVC)
        foodListNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(foodListNC.navigationBar)
        
        let tabBarList = [foodListNC, contactsVC, profileVC, basketVC]
        
        viewControllers = tabBarList
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
}

// MARK: - View Controllers
class ContactsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
    }
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
    }
}

class BasketViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
    }
}
