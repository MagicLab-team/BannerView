//
//  BannerPageControl.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/30/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

/**
 BannerPageControl.
 */
@IBDesignable
public class BannerPageControl: UIView {
    
    private var currentPageView: UIView!
    private var leadingConstraing: NSLayoutConstraint!
    
    /**
     Color of the whole control. UIColor.black by default.
     */
    public var color: UIColor = UIColor.black {
        didSet {
            backgroundColor = color
        }
    }
    /**
     Current page color. UIColor.green by default.
     */
    public var currentPageColor: UIColor = UIColor.green {
        didSet {
            currentPageView.backgroundColor = currentPageColor
        }
    }
    
    private (set) var total: Int = 0
    /**
     Current page.
     */
    internal (set) public var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.2) {
                let x: CGFloat = {
                    if UIApplication.isRTL {
                        return CGFloat(self.total - 1 - self.currentPage) * self.frame.width / CGFloat(self.total)
                    } else {
                        return CGFloat(self.currentPage) * self.frame.width / CGFloat(self.total)
                    }
                }()
                let width = self.frame.width / CGFloat(self.total)
                self.currentPageView.frame = CGRect(
                    x: x,
                    y: 0,
                    width: width,
                    height: self.frame.height
                )
            }
        }
    }
    
    /**
     Setup banner page control.
     
     @param total - total pages.
     @param currentPage - current page.
     */
    public func setup(total: Int, currentPage: Int) {
        self.total = total
        backgroundColor = color
        
        addCurrentPageView()
        
        DispatchQueue.main.async {
            self.currentPage = currentPage
        }
    }
    
    
    //MARK: private
    
    private func addCurrentPageView() {
        if currentPageView == nil {
            currentPageView = UIView()
            addSubview(currentPageView)
        }
        currentPageView.backgroundColor = currentPageColor
        
        bringSubview(toFront: currentPageView)
    }
}

