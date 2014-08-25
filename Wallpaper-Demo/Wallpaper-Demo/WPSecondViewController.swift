//
//  SecondViewController.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class WPSecondViewController: UIViewController {
    
    override init() {
        super.init(nibName: nil, bundle: nil)
        title = "Colors"
        tabBarItem.image = UIImage(named: "Second")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.greenColor()
    }
}
