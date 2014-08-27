//
//  SecondViewController.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

private let secondCellReuseID = "cellID"

class WPSecondViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
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
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView!.backgroundColor = UIColor.whiteColor()
        collectionView!.delegate = self;
        collectionView!.dataSource = self;
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: secondCellReuseID)
        view.addSubview(collectionView!)
    }

    private func blueHueColorForCell(cell: UICollectionViewCell) {
        let hue: CGFloat = 0.65
        cell.backgroundColor = Wallpaper.placeRandomColorWithHue(hue)
    }

    private func randomColorForCell(cell: UICollectionViewCell) {
        cell.backgroundColor = Wallpaper.placeRandomColor()
    }

    private func randomColorAndAlphaForCell(cell: UICollectionViewCell) {
        var alpha = CGFloat(arc4random_uniform(1000)) / CGFloat(1000)
        if alpha == 0.0 {
            alpha = 0.05
        }
        cell.backgroundColor = Wallpaper.placeRandomColorWithAlpha(alpha)
    }

    private func randomGreyscaleColorForCell(cell:UICollectionViewCell) {
        cell.backgroundColor = Wallpaper.placeRandomGreyscaleColor()
    }

    private func randomGreyscaleColorAndAlphaForCell(cell: UICollectionViewCell) {
        var alpha = CGFloat(arc4random_uniform(1000)) / CGFloat(1000)
        if alpha == 0.0 {
            alpha = 0.05
        }
        cell.backgroundColor = Wallpaper.placeRandomGreyscaleColor(alpha)
    }

    private func randomColorWithHueOfGreenForCell(cell: UICollectionViewCell) {
        cell.backgroundColor = Wallpaper.placeRandomColorWithHueOfColor(UIColor.greenColor())
    }
}

extension WPSecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 6
    }

    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(secondCellReuseID, forIndexPath: indexPath) as UICollectionViewCell

        if (indexPath.section == 0) {
            blueHueColorForCell(collectionCell)
        } else if indexPath.section == 1 {
            randomColorForCell(collectionCell)
        } else if(indexPath.section == 2) {
            randomColorAndAlphaForCell(collectionCell)
        } else if (indexPath.section == 3) {
            randomGreyscaleColorForCell(collectionCell)
        } else if (indexPath.section == 4) {
            randomGreyscaleColorAndAlphaForCell(collectionCell)
        } else {
            randomColorWithHueOfGreenForCell(collectionCell)
        }

        return collectionCell
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSizeMake(40.0, 40.0)
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    }
}
