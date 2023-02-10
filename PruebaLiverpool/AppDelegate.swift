//
//  AppDelegate.swift
//  PruebaLiverpool
//
//  Created by Osvaldo Salas Palomo on 10/02/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.pushViewController(StoreRouter.createModule(), animated: false)
        window?.rootViewController = navigationController
        
        self.window?.makeKeyAndVisible()
        return true
    }
}

