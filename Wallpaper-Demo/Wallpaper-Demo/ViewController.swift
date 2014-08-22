//
//  ViewController.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/22/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyanColor()
        imageView.frame = CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height)
        view.addSubview(imageView)
        
        Wallpaper.placeKittenGreyscaleImage(CGSizeMake(100, 200), completion: { (image) -> () in
            if let theImage = image {
                imageView.image = theImage
            }
        })
        
        let label = UILabel(frame: CGRectMake(10.0, 100.0, 300.0, 300.0))
        label.textColor = UIColor.redColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        view.addSubview(label)
        
        Wallpaper.placeHipsterIpsum(1, shotOfLatin: true) { (hipsterIpsum) -> () in
            if let theText = hipsterIpsum {
                label.text = theText
            }
        }
    }
}

