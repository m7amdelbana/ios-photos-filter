//
//  UIButton+Extensions.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setShadow() {
        self.layer.shadowColor = UIColor(hex: 0x000000, a: 0.10).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
    
    /**
     Adding a localized title to button
     
     - parameter key: The key localized to be a title of button with .normal style
     */
    func setTitle(_ text: String) {
        self.setTitle(text, for: .normal)
    }
}

