//
//  BannerPageControl.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/30/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

@IBDesignable
public class BannerPageControl: UIView {
    
    private var currentPageView: UIView!
    private var leadingConstraing: NSLayoutConstraint!
    
    public var color: UIColor = UIColor.black {
        didSet {
            backgroundColor = color
        }
    }
    public var currentPageColor: UIColor = UIColor.green {
        didSet {
            currentPageView.backgroundColor = currentPageColor
        }
    }
    
    private (set) var total: Int = 0
    public var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.2) {
                let x = CGFloat(self.currentPage) * self.frame.width / CGFloat(self.total)
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
    
    public func setup(total: Int, currentPage: Int) {
        self.total = total
        backgroundColor = color
        
        addCurrentPageView()
        
        self.currentPage = currentPage
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

