//
//  BannerCollectionCell.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


/**
 BannerCollectionCell.
 */
public class BannerCollectionCell: UICollectionViewCell {
    
    private var _imageView: UIImageView?
    public var imageView: UIImageView {
        get {
            if let imageView = _imageView {
                return imageView
            }
            let imageView = UIImageView(frame: bounds)
            imageView.contentMode = .scaleAspectFill
            contentView.addSubview(imageView)
            imageView.addConstraintsAlignedToSuperview()
            
            _imageView = imageView
            
            return imageView
        }
    }
    
    public var bannerItem: BannerItem? {
        didSet {
            imageView.image = bannerItem?.image
        }
    }
}

