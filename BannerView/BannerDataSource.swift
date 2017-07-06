//
//  BannerDataSource.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


typealias BannerItemHandler = (BannerItem, Int)->Void


private let cellIdentifier = "BannerView.BannerCollectionCell"


class BannerDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private (set) weak var bannerView: BannerView!
    private (set) var bannerItems: [BannerItem]?
    private var totalItems: Int {
        if let bannerItems = self.bannerItems {
            return bannerItems.count
        }
        return 0
    }
    private (set) var currentPage: Int = 0 {
        didSet {
            if let bannerItem = bannerItems?.safelyGet(currentPage) {
                if bannerViewScrollType == .alwaysForward,
                    currentPage + 1 == totalItems {
                    delegate?.bannerView?(
                        bannerView: bannerView,
                        didScrollTo: bannerItem,
                        with: 0
                    )
                } else {
                    delegate?.bannerView?(
                        bannerView: bannerView,
                        didScrollTo: bannerItem,
                        with: currentPage
                    )
                }
            }
            
            if bannerViewScrollType == .alwaysForward,
                currentPage + 1 == totalItems {
                
                collectionView?.scrollToItem(
                    at: IndexPath(item: 0, section: 0),
                    at: .centeredHorizontally,
                    animated: false
                )
            }
        }
    }
    private var timerIsWorking = true
    private var movingForward = true
    
    private weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.register(
                BannerCollectionCell.self,
                forCellWithReuseIdentifier: cellIdentifier
            )
        }
    }
    private var bannerCollectionView: BannerCollectionView? {
        return collectionView as? BannerCollectionView
    }
    
    private var bannerViewScrollType: BannerViewScrollType = .fromStart
    private var timeForOneItem: TimeInterval = 3
    
    var delegate: BannerViewDelegate?
    
    
    init(bannerView: BannerView,
         bannerViewScrollType: BannerViewScrollType,
         timeForOneItem: TimeInterval,
         bannerItems: [BannerItem],
         delegate: BannerViewDelegate) {
        
        super.init()
        
        self.bannerView = bannerView
        self.bannerViewScrollType = bannerViewScrollType
        self.timeForOneItem = timeForOneItem
        self.bannerItems = bannerItems
        if bannerViewScrollType == .alwaysForward,
            let bannerItem = bannerItems.safelyGet(0) {
            self.bannerItems?.append(bannerItem)
        }
        self.delegate = delegate
        
        if UIApplication.isRTL {
            currentPage = (self.bannerItems?.count ?? 0) - 1
        } else {
            currentPage = 0
        }
    }
    
    
    func startSlider() {
        timerIsWorking = true
        timerScrollCollection(after: timeForOneItem)
    }
    
    func stopSlider() {
        timerIsWorking = false
    }
    
    var isUserInteracts: Bool {
        if let bannerCollectionView = self.bannerCollectionView {
            return bannerCollectionView.isTouching
        }
        return false
    }
    
    var canAutomaticallyScroll: Bool {
        return timerIsWorking && !isUserInteracts
    }
    
    private func timerScrollCollection(after: TimeInterval) {
        if !timerIsWorking {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + after) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.canAutomaticallyScroll {
                let indexPath = strongSelf.indexPathToScroll(
                    totalPages: strongSelf.totalItems
                )
                if indexPath.item >= 0 && indexPath.item < strongSelf.totalItems {
                    strongSelf.collectionView?.scrollToItem(
                        at: indexPath,
                        at: .centeredHorizontally,
                        animated: true
                    )
                }
                strongSelf.timerScrollCollection(after: strongSelf.timeForOneItem)
            } else {
                strongSelf.timerScrollCollection(after: strongSelf.timeForOneItem * 2)
            }
        }
    }
    
    private func indexPathToScroll(totalPages: Int) -> IndexPath {
        switch bannerViewScrollType {
        case .fromStart:
            if currentPage + 1 < totalPages {
                return IndexPath(item: currentPage + 1, section: 0)
            } else {
                return IndexPath(item: 0, section: 0)
            }
        case .reverse:
            if movingForward {
                if currentPage + 1 < totalPages {
                    return IndexPath(item: currentPage + 1, section: 0)
                } else {
                    movingForward = false
                    return IndexPath(item: currentPage - 1, section: 0)
                }
            } else {
                if currentPage - 1 >= 0 {
                    return IndexPath(item: currentPage - 1, section: 0)
                } else {
                    movingForward = true
                    return IndexPath(item: currentPage + 1, section: 0)
                }
            }
        case .alwaysForward:
            return IndexPath(item: currentPage + 1, section: 0)
        }
    }
    
    
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        self.collectionView = collectionView
        
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    //MARK: UICollectionViewDataSource, UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indexPathForDelegate: IndexPath = {
            if bannerViewScrollType == .alwaysForward,
                indexPath.item == totalItems - 1 {
                return IndexPath(item: 0, section: 0)
            } else {
                return indexPath
            }
        }()
        
        if let cell = delegate?.bannerView?(
            bannerView: bannerView,
            collectionView: collectionView,
            cellForItemAt: indexPathForDelegate
            ) {
            return cell
        }
        
        let cell: BannerCollectionCell = {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
                ) as? BannerCollectionCell else {
                    return BannerCollectionCell()
            }
            return cell
        }()
        
        cell.bannerItem = bannerItems?.safelyGet(indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let bannerItem = bannerItems?[indexPath.item] {
            //            clickHandler?(bannerItem, indexPath.item)
            delegate?.bannerView?(
                bannerView: bannerView,
                didSelectItem: bannerItem,
                with: indexPath.item
            )
        }
    }
    
    
    //MARK: scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageFloat = scrollView.contentOffset.x / scrollView.frame.width
        if UIApplication.isRTL {
            let page = Int(ceil(pageFloat))
            currentPage = (page - (totalItems-1)) * -1
        } else {
            let page = Int(pageFloat)
            currentPage = page
        }
    }
}

