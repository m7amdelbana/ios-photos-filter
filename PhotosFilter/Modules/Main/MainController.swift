//
//  MainController.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/12/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import RxSwift

class MainController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnApply: UIButton!
    
    var originalImage = UIImage()
    let disposeBag = DisposeBag()
    var isFilterSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController, let photosController: PhotosController = nav.viewControllers.first as? PhotosController  else { return }
        
        photosController.selectedImage.subscribe(onNext: { [weak self] image in
            self?.originalImage = image
            self?.updateUI(with: image)
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        imageView.image = image
        btnApply.isHidden = false
    }
    
    @IBAction func applyAction(_ sender: Any) {
        guard let sourceImage = self.imageView.image else { return }
        btnApply.setTitle(isFilterSet ? "Apply" : "Undo")
        
        if isFilterSet {
            imageView.image = originalImage
        } else {
            applyFilter(on: sourceImage)
        }
        
        isFilterSet.toggle()
    }
    
    func applyFilter(on image: UIImage) {
        FILTER.applyFilter(to: image, with: .CICMYKHalftone)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.imageView.image = filteredImage
                }
            }).disposed(by: disposeBag)
    }
}

