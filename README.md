ios-photos-filter with Rx
======================

This is a simple app on how to create filter effect on images at Swift I just used a one effect called "CICMYKHalftone", You can add filters as you want and use them as exist at this project.

======================

How to use
======================

- Add Filter name at FilterName.

enum FilterName: String {
    case CICMYKHalftone = "CICMYKHalftone"
}

- Call function applyFilter from FiltersService with image and filter name.

func applyFilter(to inputImage: UIImage, with filterName: FilterName) -> Observable<UIImage> {
    return Observable<UIImage>.create { observer in
        self.applyFilter(to: inputImage, with: filterName) { filteredImage in
            observer.onNext(filteredImage)
        }
        return Disposables.create()
    }
}

# Author

Created by Mohamed Elbana on 2020. Copyright © 2020 Mohamed Elbana.
[LinkedIN](https://www.linkedin.com/in/mohamed-elbana-a5a214ab)

Please don't hesitate to ask any clarifying questions about the project if you have any.


