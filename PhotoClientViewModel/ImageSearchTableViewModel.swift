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

    public var imageEntities: [ImageEntity]?
    public let network: Networking

    public init(imageSearch: ImageSearching, network: Networking) {
        self.imageSearch = imageSearch
        self.network = network
    }

    public func startSearch() -> Observable<[ImageSearchTableViewCellModeling]> {
        return imageSearch.searchImages().map { response in
            self.imageEntities = response.images
            return response.images.map { imageEntity in
                ImageSearchTableViewCellModel(image: imageEntity, network: self.network)
            }
        }
    }

    // MARK: - private variables

    private let imageSearch: ImageSearching
//    private let network: Networking
}
