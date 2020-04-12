//
//  PhotosController.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import Photos
import RxSwift

class PhotosController: UICollectionViewController {
    
    private var images = [PHAsset]()
    private let manager = PHImageManager.default()
    private var cellSize = CGSize()
    
    private let selectedImageSubject = PublishSubject<UIImage>()
    var selectedImage: Observable<UIImage> {
        return selectedImageSubject.asObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkPermission()
    }
    
    private func setupView() {
        self.collectionView.registerCellNib(cellClass: PhotoCell.self)
        self.collectionView.contentInset = UIEdgeInsets.init(t: 10, l: 5, b: 10, r: 5)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        
        let square: CGFloat = view.bounds.width / 3 - 5
        cellSize = CGSize(width: square, height: square)
        layout.itemSize = cellSize
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionView.collectionViewLayout = layout
    }
    
    private func checkPermission() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            if status == .authorized {
                self.getPhotos()
            }
        }
    }
    
    private func getPhotos() {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects { (object, count, stop) in
            self.images.append(object)
        }
        self.images.reverse()
        self.reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @IBAction func doneAction(_ sender: Any) {
        dismiss()
    }
    
    private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: PhotoCell.self, indexPath: indexPath)
        let asset = images[indexPath.row]
        requestImage(of: asset, in: cellSize) { image, info in
            if let image = image {
                cell.configure(with: image)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = images[indexPath.row]
        let size = CGSize(width: view.bounds.width, height: view.bounds.width)
        requestImage(of: asset, in: size) { image, info in
            guard let info = info else { return }
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                if let image = image {
                    self.selectedImageSubject.onNext(image)
                    self.dismiss()
                }
            }
        }
    }
    
    private func requestImage(of asset: PHAsset, in size: CGSize, completion: @escaping(UIImage?, [AnyHashable:Any]?) -> ()) {
        manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { image, info in
            completion(image, info)
        }
    }
}
