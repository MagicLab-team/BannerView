//
//  BannerCollectionView.swift
//  BannerView
//
//  Created by Roman Sorochak on 7/6/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


public class BannerCollectionView: UICollectionView {
    
    var isTouching: Bool = false
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        isTouching = true
        
        print("touchesBegan: \(isTouching)")
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        isTouching = true
        
        print("touchesMoved: \(isTouching)")
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isTouching = false
        
        print("touchesEnded: \(isTouching)")
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        isTouching = false
        
        print("touchesCancelled: \(isTouching)")
    }
}
