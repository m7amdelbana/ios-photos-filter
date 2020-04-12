//
//  PhotoCell.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
