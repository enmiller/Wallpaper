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
    
    init() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

        super.init(nibName: nil, bundle: nil)

        title = "Colors"
        tabBarItem.image = UIImage(named: "Second")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomInset = self.tabBarController!.tabBar.bounds.height
        let edgeInsets = UIEdgeInsetsMake(20.0, 0.0, bottomInset, 0.0)

        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: secondCellReuseID)
        collectionView.contentInset = edgeInsets

        view.addSubview(collectionView)
    }

    fileprivate func blueHueColorForCell(cell: UICollectionViewCell) {
        let hue: CGFloat = 0.65
        cell.backgroundColor = Wallpaper.placeRandomColorWithHue(hue)
    }

    fileprivate func randomColorForCell(cell: UICollectionViewCell) {
        cell.backgroundColor = Wallpaper.placeRandomColor()
    }

    fileprivate func randomColorAndAlphaForCell(cell: UICollectionViewCell) {
        var alpha = CGFloat(arc4random_uniform(1000)) / CGFloat(1000)
        if alpha == 0.0 {
            alpha = 0.05
        }
        cell.backgroundColor = Wallpaper.placeRandomColorWithAlpha(alpha)
    }

    fileprivate func randomGreyscaleColorForCell(cell:UICollectionViewCell) {
        cell.backgroundColor = Wallpaper.placeRandomGreyscaleColor()
    }

    fileprivate func randomGreyscaleColorAndAlphaForCell(cell: UICollectionViewCell) {
        var alpha = CGFloat(arc4random_uniform(1000)) / CGFloat(1000)
        if alpha == 0.0 {
            alpha = 0.05
        }
        cell.backgroundColor = Wallpaper.placeRandomGreyscaleColor(alpha)
    }

    fileprivate func randomColorWithHueOfGreenForCell(cell: UICollectionViewCell) {
        cell.backgroundColor = Wallpaper.placeRandomColorWithHueOfColor(color: UIColor.green)
    }
}

extension WPSecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellReuseID, for: indexPath)
        
        let section = Section(rawValue: indexPath.section)!
        switch (section) {
        case .BlueHues:
            blueHueColorForCell(cell: collectionCell)
        case .RandomColors:
            randomColorForCell(cell: collectionCell)
        case .RandomAlphaColor:
            randomColorAndAlphaForCell(cell: collectionCell)
        case .RandomGreyscale:
            randomGreyscaleColorForCell(cell: collectionCell)
        case .RandomAlphaGreyscale:
            randomColorWithHueOfGreenForCell(cell: collectionCell)
        case .RandomGreenHue:
            randomGreyscaleColorAndAlphaForCell(cell: collectionCell)
            
        }
        
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40.0, height: 40.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 10.0, bottom: 60.0, right: 10.0)
    }
}
