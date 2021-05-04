//
//  AppDelegate.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 21/02/2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var realm: Realm!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        realm = try! Realm()
        return true
    }

}

