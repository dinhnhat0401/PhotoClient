//
//  ImageSearchTableViewCellModel.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import PhotoClientModel

public final class ImageSearchTableViewCellModel: ImageSearchTableViewCellModeling {
    public let id: UInt64
    public let pageImageSizeText: String
    public let tagText: String

    internal init(image: ImageEntity) {
        id = image.id
        pageImageSizeText = "\(image.pageImageWidth) x \(image.pageImageHeight)"
        tagText = image.tags.joined(separator: ", ")
    }
}
