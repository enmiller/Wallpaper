//
//  WPCollectionViewCell.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class WPCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        imageView.frame = bounds
        imageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        addSubview(imageView)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
}
