//
//  FirstViewController.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

private let firstCellReuseID = "cellID"

enum ImageType : Int {
    case Kittens = 0, Placeholders, Bacon, GreyscaleKittens, Random, Downey, GreyscaleRandom
}

class WPFirstViewController: UIViewController {
    
    var collectionView: UICollectionView

    override init() {
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
        title = "Images"
        tabBarItem.image = UIImage(named: "First")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.registerClass(WPCollectionViewCell.self, forCellWithReuseIdentifier: firstCellReuseID)

        view.addSubview(collectionView)
    }

    private func randomPlaceholderImageForCell(cell: WPCollectionViewCell) {
        let random = ImageType.fromRaw(Int(arc4random_uniform(6)))!
        let size = cell.bounds.size
        let imageView = cell.imageView
        
        let completion: (image: UIImage?) -> Void = { image in
            imageView.image = image
        }

        switch (random) {
        case .Kittens:
            Wallpaper.placeKittenImage(size, completion)
        case .Placeholders:
            Wallpaper.placeHolderImage(size, completion)
        case .Bacon:
            Wallpaper.placeBaconImage(size, completion)
        case .GreyscaleKittens:
            Wallpaper.placeKittenGreyscaleImage(size, completion)
        case .Random:
            Wallpaper.placeRandomImage(size, completion)
        case .Downey:
            Wallpaper.placeDowneyImage(size, completion)
        case .GreyscaleRandom:
            Wallpaper.placeRandomGreyscaleImage(size, completion)
        }
    }
}

extension WPFirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        let range = NSMakeRange(35, 300)
        return (range.location + Int(arc4random_uniform(UInt32(range.length))))
    }

    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(firstCellReuseID, forIndexPath: indexPath) as WPCollectionViewCell
        randomPlaceholderImageForCell(collectionCell)

        return collectionCell
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        let widthRange = NSMakeRange(35, 250)
        let width = CGFloat((widthRange.location + Int(arc4random_uniform(UInt32(widthRange.length)))))

        let heightRange = NSMakeRange(35, 300)
        let height = CGFloat((heightRange.location + Int(arc4random_uniform(UInt32(heightRange.length)))))

        return CGSizeMake(width, height)
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    }
}
