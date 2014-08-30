//
//  SecondViewController.swift
//  Wallpaper-Demo
//
//  Created by Eric Miller on 8/25/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit
import Foundation

private let secondCellReuseID = "cellID"

enum Section : Int {
    case BlueHues = 0, RandomColors, RandomAlphaColor, RandomGreyscale, RandomAlphaGreyscale, RandomGreenHue
}

class WPSecondViewController: UIViewController {
    
    var collectionView: UICollectionView
    
    override init() {
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())

        super.init(nibName: nil, bundle: nil)

        title = "Colors"
        tabBarItem.image = UIImage(named: "Second")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomInset = self.tabBarController.tabBar.bounds.height
        let edgeInsets = UIEdgeInsetsMake(20.0, 0.0, bottomInset, 0.0)

        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: secondCellReuseID)
        collectionView.contentInset = edgeInsets

        view.addSubview(collectionView)
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

        if let sectionIndex = indexPath {
            let section = Section.fromRaw(sectionIndex.section)!
            switch (section) {
                case .BlueHues:
                    blueHueColorForCell(collectionCell)
                case .RandomColors:
                    randomColorForCell(collectionCell)
                case .RandomAlphaColor:
                    randomColorAndAlphaForCell(collectionCell)
                case .RandomGreyscale:
                    randomGreyscaleColorForCell(collectionCell)
                case .RandomAlphaGreyscale:
                    randomGreyscaleColorAndAlphaForCell(collectionCell)
                case .RandomGreenHue:
                    randomColorWithHueOfGreenForCell(collectionCell)
            }
        }

        return collectionCell
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSizeMake(40.0, 40.0)
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 10.0, bottom: 60.0, right: 10.0)
    }
}
