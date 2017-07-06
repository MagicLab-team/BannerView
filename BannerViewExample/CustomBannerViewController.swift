//
//  CustomBannerViewController.swift
//  BannerView
//
//  Created by Roman Sorochak on 7/6/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import BannerView
import Reusable


class CustomBannerViewController: UIViewController, BannerViewDelegate {
    
    let items: [BannerItem] = [
        BannerItem(image: "banner_1".localizedImage),
        BannerItem(image: "banner_2".localizedImage),
        BannerItem(image: "banner_3".localizedImage)
    ]
    
    var bannerView: BannerView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bannerView = BannerView(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        )
        view.addSubview(bannerView)
        
        bannerView.center = view.center
        
        bannerView.setup(
            type: .alwaysForward,
            timeForOneItem: 1,
            bannerItems: items,
            delegate: self
        )
        bannerView.pageControl.currentPageColor = UIColor.customGreenColor()
    }
    
    
    func bannerView(bannerView: BannerView, didScrollTo: BannerItem, with index: Int) {
        print("didScrollTo: \(index)")
    }
    
    func bannerView(bannerView: BannerView, didSelectItem: BannerItem, with index: Int) {
        print("didSelectItem: \(index)")
    }
    
    func bannerView(bannerView: BannerView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueCell(for: indexPath) as Cell
        
        cell.myImageView.image = items[indexPath.item].image
        cell.title.text = "Custom cell"
        
        return cell
    }
}
