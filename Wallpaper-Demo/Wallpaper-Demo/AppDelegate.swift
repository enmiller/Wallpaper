//
//  AppDelegate.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/22/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var tabBarController: UITabBarController?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = WPFirstViewController()
        let secondVC = WPSecondViewController()
        tabBarController = UITabBarController()
        tabBarController!.viewControllers = [firstVC, secondVC]
        self.window!.rootViewController = tabBarController
        
        self.window!.makeKeyAndVisible()
    }
}

