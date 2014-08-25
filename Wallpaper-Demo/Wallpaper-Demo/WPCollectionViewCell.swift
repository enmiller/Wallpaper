//
//  WPCollectionViewCell.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class WPCollectionViewCell: UICollectionViewCell {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView = UIImageView()
    
    override init() {
        super.init()
        imageView.frame = bounds
    }
    
    override func prepareForInterfaceBuilder() {
        imageView.image = nil
    }
    
}
