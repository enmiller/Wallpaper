//
//  FirstViewController.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

private let firstCellReuseID = "cellID"

class WPFirstViewController: UIViewController {
    
    var collectionView: UICollectionView?

    override init() {
        super.init(nibName: nil, bundle: nil)
        title = "Images"
        tabBarItem.image = UIImage(named: "First")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView!.backgroundColor = UIColor.whiteColor()
        collectionView!.delegate = self;
        collectionView!.dataSource = self;
        collectionView!.registerClass(WPCollectionViewCell.self, forCellWithReuseIdentifier: firstCellReuseID)
        view.addSubview(collectionView!)
    }

    private func randomPlaceholderImageForCell(cell: WPCollectionViewCell) {
        let random = arc4random_uniform(6)
        switch (random) {
        case 0:
            Wallpaper.placeKittenImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
        case 1:
            Wallpaper.placeHolderImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
        case 2:
            Wallpaper.placeBaconImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
        case 3:
            Wallpaper.placeKittenGreyscaleImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
        case 4:
            Wallpaper.placeRandomImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
        case 5:
            Wallpaper.placeDowneyImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
        default:
            Wallpaper.placeRandomGreyscaleImage(cell.bounds.size, completion: { image in
                cell.imageView.image = image
            })
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
