//
//  SceneDelegate.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 21/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let navigationVC = window?.rootViewController as! UINavigationController
        let gbeseListVC = navigationVC.topViewController as! GbeseListViewController
        gbeseListVC.realm = appdelegate.realm

    }

}

