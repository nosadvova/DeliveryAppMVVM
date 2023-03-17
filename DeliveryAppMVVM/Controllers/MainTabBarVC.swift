//
//  MainTabBarVC.swift
//  DeliveryAppMVVM
//
//  Created by Vova Novosad on 27.02.2023.
//

import UIKit
import FirebaseAuth

class MainTabBarVC: UITabBarController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        logOut()
        authenticateUser()
    }
    
    
    //MARK: - Selectors
    

    
    
    //MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: NumberVC())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configureControllers()
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            print("Done")
        } catch {
            print("logOut() error")
        }
    }
    
    //MARK: - Functionality
    
     func configureControllers() {
        let marketVC = templateNavController(image: UIImage(named: "market")!, controller: MarketVC(), title: "Market")
        let basketVC = templateNavController(image: UIImage(named: "basket")!, controller: BasketVC(), title: "Basket")
        
        viewControllers = [marketVC, basketVC]
    }
    
    private func templateNavController(image: UIImage, controller: UIViewController, title: String) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: controller)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationVC.navigationBar.standardAppearance = appearance
        navigationVC.navigationBar.scrollEdgeAppearance = navigationVC.navigationBar.standardAppearance
        
        return navigationVC
    }
}
