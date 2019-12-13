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
    public var cellModels = BehaviorRelay<[ImageSearchTableViewCellModeling]>(value: [])

    public init(imageSearch: ImageSearching, network: Networking) {
        self.imageSearch = imageSearch
        self.network = network
    }

    public func startSearch() {
        imageSearch.searchImages().map { response in
            response.images.map { [weak self] imageEntity in
                return ImageSearchTableViewCellModel(image: imageEntity, network: self?.network)
            }
        }.subscribe(onNext: { [weak self] (models) in
            self?.cellModels.accept(models)
            }).disposed(by: disposeBag)
    }

    // MARK: - private variables

    private let imageSearch: ImageSearching
    private let network: Networking
    private let disposeBag = DisposeBag()
//    private var _cellModels = Observable<[ImageSearchTableViewCellModeling]>.just([])
}
