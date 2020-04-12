//
//  FiltersService.swift
//  PhotosFilter
//
//  Created by Mohamed Elbana on 4/13/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

let FILTER = FiltersService()

enum FilterName: String {
    case CICMYKHalftone = "CICMYKHalftone"
}

class FiltersService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, with filterName: FilterName) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage, with: filterName) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to input: UIImage, with filterName: FilterName, completion: @escaping ((UIImage) -> ())) {
        let filter = createFilter(with: filterName)
        if let sourceImage = CIImage(image: input) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgimg, scale: input.scale, orientation: input.imageOrientation)
                completion(processedImage)
            }
        }
    }
    
    private func createFilter(with filterName: FilterName) -> CIFilter {
        let filter = CIFilter(name: filterName.rawValue)!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        return filter
    }
}

