//
//  GridFlowLayout.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    
    init(width: CGFloat, columns: Int, padding: CGFloat) {
        super.init()
        configure(width: width, columns: columns, padding: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(width: CGFloat, columns: Int, padding: CGFloat) {
        let minimumSpacing: CGFloat = 10
        let availableWidth = width - (padding * (CGFloat(columns) - 1)) - (minimumSpacing * (CGFloat(columns) - 1))
        let itemWidth = availableWidth / CGFloat(columns)
        self.sectionInset = UIEdgeInsets(all: padding)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    }
}
