//
//  Array+Safety.swift
//  BannerView
//
//  Created by Roman Sorochak on 6/29/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import Foundation

extension Array {
    
    func safelyGet(_ i : Int) -> Element? {
        if i >= 0 && i < count {
            return self[i]
        } else {
            return nil
        }
    }
    
    mutating func safelyDelete(_ i: Int) -> Element? {
        if i >= 0 && i < count {
            return remove(at: i)
        } else {
            return nil
        }
    }
}

