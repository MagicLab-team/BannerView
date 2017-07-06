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
    
    private var collectionView: BannerCollectionView!
    private var dataSource: BannerDataSource!
    private (set) public var pageControl: BannerPageControl!
    
    
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
        collectionView = BannerCollectionView(
            frame: bounds,
            collectionViewLayout: layout
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        
        addSubview(collectionView)
        
        collectionView.clipsToBounds = true
        collectionView.addConstraintsAlignedToSuperview(top: 2)
        
        pageControl = BannerPageControl()
        pageControl.backgroundColor = UIColor.black
        addSubview(pageControl)
        addContsraintsToPageControl(pageControl: pageControl)
    }
    
    private func addContsraintsToPageControl(pageControl: UIView) {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(
            NSLayoutConstraint(
                item: pageControl,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: self,
                attribute: NSLayoutAttribute.width,
                multiplier: CGFloat(2) / 3,
                constant: 0
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: pageControl,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 1
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: pageControl,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self,
                attribute: NSLayoutAttribute.top,
                multiplier: 1,
                constant: 0
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: pageControl,
                attribute: NSLayoutAttribute.centerX,
                relatedBy: NSLayoutRelation.equal,
                toItem: self,
                attribute: NSLayoutAttribute.centerX,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    
    /**
     * Setup
     */
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
                self.pageControl.currentPage = index
                
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
        
        pageControl.setup(total: bannerItems.count, currentPage: 0)
        
        dataSource.startSlider()
    }
}
