//
//  BannerView.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


/**
 BannerViewDelegate.
 */
@objc public protocol BannerViewDelegate {
    
    /**
     Notifies when banner view scrolls to the next item.
     */
    @objc optional func bannerView(bannerView: BannerView, didScrollTo: BannerItem, with index: Int)
    
    /**
     Notifies when user selects item.
     */
    @objc optional func bannerView(bannerView: BannerView, didSelectItem: BannerItem, with index: Int)
    
    /**
     Returns cell for collection view.
     */
    @objc optional func bannerView(bannerView: BannerView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell?
}

/**
 BannerViewScrollType contains different scroll types.
 */
public enum BannerViewScrollType {
    /**
     BannerView scrolls to the start after the last item.
     */
    case fromStart
    /**
     BannerView scrolls to the end item and then to the first item through all items.
     */
    case reverse
    /**
     BannerView always scrolls forward.
     */
    case alwaysForward
}


/**
 * BannerView - contains all public API.
 */
@IBDesignable
public class BannerView: UIView {
    
    @IBInspectable public var delegate: BannerViewDelegate?
    
    private var bannerDataSource: BannerDataSource!
    /**
     Collection view of BannerView.
     */
    private (set) public var collectionView: BannerCollectionView!
    
    /**
     pageControl property allows to setup BannerPageControl.
     */
    private (set) public var pageControl: BannerPageControl!
    
    /**
     Current page.
     */
    public var currentPage: Int {
        get {
            return bannerDataSource.currentPage
        }
    }
    
    
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
     Setup banner view.
     
     @param type - scroll type.
     @param timeForOneItem - indicates how much time user can see one item.
     @param bannerItems - items to show.
     @param automaticallyScrolls - indicates whether banner view will scroll items automatically. By default is true.
     @param delegate - delegate.
     */
    public func setup(
        type: BannerViewScrollType,
        timeForOneItem: TimeInterval,
        bannerItems: [BannerItem],
        automaticallyScrolls: Bool = true,
        delegate: BannerViewDelegate?) {
        
        bannerDataSource = BannerDataSource(
            bannerView: self,
            bannerViewScrollType: type,
            timeForOneItem: timeForOneItem,
            bannerItems: bannerItems,
            delegate: self
        )
        self.delegate = delegate
        collectionView.dataSource = bannerDataSource
        collectionView.delegate = bannerDataSource
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentOffset = CGPoint(x: 0, y: 0)
        
        pageControl.setup(total: bannerItems.count, currentPage: 0)
        
        if automaticallyScrolls {
            startAutomaticScrolling()
        }
    }
    
    /**
     Starts scrolling automatically.
     */
    public func startAutomaticScrolling() {
        bannerDataSource.startSlider()
    }
    
    /**
     Stops scrolling automatically.
     */
    public func stopAutomaticScrolling() {
        bannerDataSource.stopSlider()
    }
}

extension BannerView: BannerViewDelegate {
    
    public func bannerView(bannerView: BannerView,
                           didScrollTo: BannerItem,
                           with index: Int) {
        self.pageControl.currentPage = index
        
        delegate?.bannerView?(
            bannerView: bannerView,
            didScrollTo: didScrollTo,
            with: index
        )
    }
    
    public func bannerView(bannerView: BannerView,
                           didSelectItem: BannerItem,
                           with index: Int) {
        self.delegate?.bannerView?(
            bannerView: self,
            didSelectItem: didSelectItem,
            with: index
        )
    }
    
    public func bannerView(bannerView: BannerView,
                           collectionView: UICollectionView,
                           cellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        return delegate?.bannerView?(
            bannerView: self,
            collectionView: collectionView,
            cellForItemAt: indexPath
        )
    }
}
