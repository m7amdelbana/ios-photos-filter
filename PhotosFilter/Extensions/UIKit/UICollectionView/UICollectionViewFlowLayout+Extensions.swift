//
//  UICollectionViewFlowLayout+Extensions.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    convenience init(in superView: UIView, height: CGFloat, padding: CGFloat, sectionInset: UIEdgeInsets, columns: Int) {
        self.init()
        self.itemSize = CGSize(width: superView.frame.width / (CGFloat(columns)) - padding, height: height)
        self.sectionInset = sectionInset
    }
}
