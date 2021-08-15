//
//  ImageDetailsViewModel.swift
//  PhotoClientViewModel
//
//  Created by Đinh Văn Nhật on 2021/08/13.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import PhotoClientModel

public protocol ImageDetailsViewModeling {
    var viewCellModels: [ImageDetailsCollectionViewCellModeling]? { get }
}

public final class ImageDetailsViewModel: ImageDetailsViewModeling {

    public var viewCellModels: [ImageDetailsCollectionViewCellModeling]?

    public init(_ viewModel: ImageSearchTableViewModeling) {
        self.viewCellModels = viewModel.imageEntities?.map { entity in
            ImageDetailsCollectionViewCellModel(entity, viewModel.network)
        }
    }
}
