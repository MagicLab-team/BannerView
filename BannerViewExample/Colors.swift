//
//  Colors.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/30/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(rgbValue: UInt, _ alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static func customGreenColor(_ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(rgbValue: 0x1F806C, alpha)
    }
}
