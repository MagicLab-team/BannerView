//
//  UIApplication+RtL.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


extension UIApplication {
    
    static var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.rightToLeft
    }
}

