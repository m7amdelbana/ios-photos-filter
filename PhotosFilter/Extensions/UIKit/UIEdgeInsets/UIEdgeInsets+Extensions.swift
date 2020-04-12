//
//  UIEdgeInsets+Extensions.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    init(t top: CGFloat = 0, l left: CGFloat = 0, b bottom: CGFloat = 0, r right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
    init(all value: CGFloat) {
        self.init(t: value, l: value, b: value, r: value)
    }
}
