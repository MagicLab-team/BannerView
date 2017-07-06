//
//  BannerCollectionView.swift
//  BannerView
//
//  Created by Roman Sorochak on 7/6/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


class BannerCollectionView: UICollectionView {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touchesBegan")
    }
}
