//
//  SceneDelegate.swift
//  DeliveryAppMVVM
//
//  Created by Vova Novosad on 27.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = MainTabBarVC()
        window?.makeKeyAndVisible()
    }
}

