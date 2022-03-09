//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by Mohamed Ramadan on 28/02/2022.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    var isCenterButtonSelected: Bool = false
    var centerButton: UIButton!
    var previousSelectedIndex: Int = 0
    
    //MARK: - Lifecycle
    static public func create() -> CustomTabBarViewController {
        let tabBarVC = UIStoryboard(name: "main", bundle: nil).instantiateViewController(identifier: "CustomTabBarViewController") as! CustomTabBarViewController
        return tabBarVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = UIViewController()
        home.view.backgroundColor = .lightGray
        home.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home") , tag: 1)
        
        let homeNav = UINavigationController(rootViewController: home)
        homeNav.navigationBar.isHidden = true
        
        let favoriteVC = UIViewController()
        favoriteVC.view.backgroundColor = .darkGray
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: #imageLiteral(resourceName: "home"), tag: 2)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        favoriteNav.navigationBar.isHidden = true
        
        let centerButtonVC = UIViewController()
        centerButtonVC.view.backgroundColor = .blue
        let centerButtonNav = UINavigationController(rootViewController: centerButtonVC)
        centerButtonNav.title = ""
        centerButtonNav.navigationBar.isHidden = true
        
        
        let wishlistVC = UIViewController()
        wishlistVC.view.backgroundColor = .green
        wishlistVC.tabBarItem = UITabBarItem(title: "Wishlist", image: #imageLiteral(resourceName: "home"), tag: 4)
        let wishlistNav = UINavigationController(rootViewController: wishlistVC)
        wishlistNav.navigationBar.isHidden = true
        
        let accountVC = UIViewController()
        accountVC.view.backgroundColor = .red
        accountVC.tabBarItem = UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "home"), tag: 5)
        let accountNav = UINavigationController(rootViewController: accountVC)
        accountNav.navigationBar.isHidden = true
        self.viewControllers = [homeNav, favoriteNav, centerButtonNav, wishlistNav, accountNav]
        
         
        let selectedColor   = UIColor.green
        let unSelectColor   = UIColor.darkGray
 
        self.tabBar.unselectedItemTintColor = unSelectColor
        self.tabBar.tintColor = selectedColor
        
        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        }
        
        setupCenterButton()
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if centerButton != nil {
            centerButton.layer.cornerRadius = centerButton.frame.size.height/2
            centerButton.clipsToBounds = true
        }
    }
    
    func setupCenterButton() {
        centerButton = UIButton(frame: .zero)
        view.addSubview(centerButton!)
        view.bringSubviewToFront(centerButton)
        view.layoutSubviews()
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: self.tabBar.topAnchor),
            centerButton.widthAnchor.constraint(equalTo: self.tabBar.heightAnchor, constant: 20 - UIViewController.safeAreaBottomHeight()),
            centerButton.heightAnchor.constraint(equalTo: self.tabBar.heightAnchor, constant: 20 - UIViewController.safeAreaBottomHeight())
        ])
        
        centerButton.setTitle("+", for: .normal)
        centerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        centerButton.backgroundColor = .black.withAlphaComponent(0.75)
        centerButton?.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
    }
    
 
    // MARK: - Actions
    @objc private func centerButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
}
 
extension UIViewController {
    static func safeAreaBottomHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    func safeAreaTopHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.top ?? 0
        }
        return 0
    }
}
