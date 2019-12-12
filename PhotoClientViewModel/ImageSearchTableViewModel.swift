//
//  ImageSearchTableViewModel.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import RxSwift
import RxCocoa
import PhotoClientModel

public final class ImageSearchTableViewModel: ImageSearchTableViewModeling {
    public var cellModels: Observable<[ImageSearchTableViewCellModeling]> {
        return _cellModels
    }

    public init(imageSearch: ImageSearching) {
        self.imageSearch = imageSearch
    }

    public func startSearch() {
        _cellModels = imageSearch.searchImages().map { response in
            response.images.map { imageEntity in
                ImageSearchTableViewCellModel(image: imageEntity)
            }
        }
    }

    // MARK: - private variables

    private let imageSearch: ImageSearching
    private let disposeBag = DisposeBag()
    private var _cellModels = Observable<[ImageSearchTableViewCellModeling]>.just([])
}
