//
//  ImageSearchTableViewCellModel.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import PhotoClientModel
import RxSwift
import UIKit

public final class ImageSearchTableViewCellModel: ImageSearchTableViewCellModeling {

    public let id: UInt64
    public let pageImageSizeText: String
    public let tagText: String

    private let network: Networking
    private let previewURL: String
    private var previewImage: UIImage?

    internal init(image: ImageEntity, network: Networking) {
        id = image.id
        pageImageSizeText = "\(image.pageImageWidth) x \(image.pageImageHeight)"
        tagText = image.tags.joined(separator: ", ")

        self.network = network
        previewURL = image.previewURL
    }

    public func getPreviewImage() -> Observable<UIImage?> {
        if let previewImage = self.previewImage {
            return Observable.just(previewImage).observe(on: MainScheduler.instance)
        }

        return network.requestImage(url: previewURL)
            .map { $0 as UIImage? }
    }

    // MARK: - private variables

    private let disposeBag = DisposeBag()
}
