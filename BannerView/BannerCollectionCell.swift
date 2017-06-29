//
//  BannerCollectionCell.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


class BannerCollectionCell: UICollectionViewCell {
    
    private var _imageView: UIImageView?
    private var imageView: UIImageView {
        get {
            if let imageView = _imageView {
                return imageView
            }
            let imageView = UIImageView(frame: bounds)
            contentView.addSubview(imageView)
            imageView.addConstraintsAlignedToSuperview()
            
            _imageView = imageView
            
            return imageView
        }
    }
    
    var bannerItem: BannerItem? {
        didSet {
            imageView.image = bannerItem?.image
        }
    }
}

