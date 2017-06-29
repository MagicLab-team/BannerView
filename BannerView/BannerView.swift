//
//  BannerView.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


@objc public protocol BannerViewDelegate {
    
    @objc optional func bannerView(bannerView: BannerView, didScrollTo: BannerItem, with index: Int)
    
    @objc optional func bannerView(bannerView: BannerView, didSelectItem: BannerItem, with index: Int)
}

public enum BannerViewScrollType {
    case fromStart
    case reverse
    case alwaysForward
}


@IBDesignable
public class BannerView: UIView {
    
    @IBInspectable public var delegate: BannerViewDelegate?
    
    private var collectionView: UICollectionView!
    private var dataSource: BannerDataSource!
    
    
    //MARK: initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: layout
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        
        addSubview(collectionView)
        
        collectionView.addConstraintsAlignedToSuperview()
    }
    
    public func setup(
        type: BannerViewScrollType,
        timeForOneItem: TimeInterval,
        bannerItems: [BannerItem],
        delegate: BannerViewDelegate) {
        self.delegate = delegate
        
        dataSource = BannerDataSource(
            bannerViewScrollType: type,
            timeForOneItem: timeForOneItem,
            bannerItems: bannerItems,
            didScrollHandler: { (bannerItem, index) in
                self.delegate?.bannerView?(
                    bannerView: self,
                    didScrollTo: bannerItem,
                    with: index
                )
        },
            clickHandler: { (bannerItem, index) in
                self.delegate?.bannerView?(
                    bannerView: self,
                    didSelectItem: bannerItem,
                    with: index
                )
        })
        collectionView.backgroundColor = UIColor.green
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        dataSource.startSlider()
    }
}
