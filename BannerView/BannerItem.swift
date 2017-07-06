//
//  BannerItem.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

/**
 Model for item that is shown in BannerCollectionCell.
 */
public class BannerItem: NSObject {
    
    private (set) public var image: UIImage?
    
    
    public init(image: UIImage?) {
        self.image = image
    }
}
