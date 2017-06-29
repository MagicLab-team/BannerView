//
//  ViewController.swift
//  BannerViewExample
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import BannerView


class ViewController: UIViewController, BannerViewDelegate {
    
    @IBOutlet weak var topBannerView: BannerView!
    @IBOutlet weak var centerBannerView: BannerView!
    @IBOutlet weak var bottomBannerView: BannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "title".localized
        
        let items: [BannerItem] = [
            BannerItem(image: "banner_1".localizedImage),
            BannerItem(image: "banner_2".localizedImage),
            BannerItem(image: "banner_3".localizedImage)
        ]
        
        topBannerView.setup(
            type: BannerViewScrollType.fromStart,
            timeForOneItem: 1,
            bannerItems: items,
            delegate: self
        )
        topBannerView.pageControl.color = UIColor.black
        topBannerView.pageControl.currentPageColor = UIColor.customGreenColor()
        
        centerBannerView.setup(
            type: BannerViewScrollType.reverse,
            timeForOneItem: 1,
            bannerItems: items,
            delegate: self
        )
        centerBannerView.pageControl.color = UIColor.black
        centerBannerView.pageControl.currentPageColor = UIColor.customGreenColor()
        
        bottomBannerView.setup(
            type: BannerViewScrollType.alwaysForward,
            timeForOneItem: 1,
            bannerItems: items,
            delegate: self
        )
        bottomBannerView.pageControl.color = UIColor.black
        bottomBannerView.pageControl.currentPageColor = UIColor.customGreenColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func bannerView(bannerView: BannerView, didScrollTo: BannerItem, with index: Int) {
        print("didScrollTo: \(index)")
    }
    
    func bannerView(bannerView: BannerView, didSelectItem: BannerItem, with index: Int) {
        print("didSelectItem: \(index)")
    }
}

