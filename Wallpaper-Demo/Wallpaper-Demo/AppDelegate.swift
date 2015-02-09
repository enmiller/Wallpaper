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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        var firstVC = WPFirstViewController()
        var secondVC = WPSecondViewController()
        tabBarController = UITabBarController()
        tabBarController!.viewControllers = [firstVC, secondVC]
        self.window!.rootViewController = tabBarController
        
        self.window!.makeKeyAndVisible()
        return true
    }
}

