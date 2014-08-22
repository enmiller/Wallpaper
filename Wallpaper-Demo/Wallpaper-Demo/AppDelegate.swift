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
    var rootController: ViewController?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        rootController = ViewController()
        self.window!.rootViewController = rootController
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

