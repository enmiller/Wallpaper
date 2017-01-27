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
    
    fileprivate let cellSizes: [CGSize]
    
    var collectionView: UICollectionView

    init() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cellSizes = WPFirstViewController.initialCellSizes()
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Images"
        tabBarItem.image = UIImage(named: "First")
    }
    
    fileprivate class func initialCellSizes() -> [CGSize] {
        var cells: [CGSize] = Array()
        let range = NSMakeRange(35, 300)
        let end: Int = (range.location + Int(arc4random_uniform(UInt32(range.length))))
        
        for _ in 0...end {
            let widthRange = NSMakeRange(35, 250)
            let width = CGFloat((widthRange.location + Int(arc4random_uniform(UInt32(widthRange.length)))))
            
            let heightRange = NSMakeRange(35, 300)
            let height = CGFloat((heightRange.location + Int(arc4random_uniform(UInt32(heightRange.length)))))
            cells.append(CGSize(width: width, height: height))
        }
        return cells
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(WPCollectionViewCell.self, forCellWithReuseIdentifier: firstCellReuseID)

        view.addSubview(collectionView)
    }

    fileprivate func randomPlaceholderImage(for cell: WPCollectionViewCell) {
        let random = ImageType(rawValue: Int(arc4random_uniform(6)))!
        let size = cell.bounds.size
        let imageView = cell.imageView
        
        let completion: (UIImage?) -> Void = { image in
            if let img = image {
                if img.size == size {
                    imageView.image = image
                }
            }
        }

        switch (random) {
        case .Kittens:
            Wallpaper.placeKittenImage(size: size, completion: completion)
        case .Placeholders:
            Wallpaper.placeHolderImage(size: size, completion: completion)
        case .Bacon:
            Wallpaper.placeBaconImage(size: size, completion: completion)
        case .GreyscaleKittens:
            Wallpaper.placeKittenGreyscaleImage(size: size, completion: completion)
        case .Random:
            Wallpaper.placeRandomImage(size: size, completion: completion)
        case .Downey:
            Wallpaper.placeDowneyImage(size: size, completion: completion)
        case .GreyscaleRandom:
            Wallpaper.placeRandomGreyscaleImage(size: size, completion: completion)
        }
    }
}

extension WPFirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellSizes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellReuseID, for: indexPath)
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        randomPlaceholderImage(for: cell as! WPCollectionViewCell);
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSizes[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    }
}
