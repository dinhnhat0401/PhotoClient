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
    public let previewURL: String
    public var previewImage: UIImage?

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

    public func cancelGetPreviewImage() {
        self.network.cancelRequestImage(url: previewURL)
    }

    public func setPreviewImage(_ image: UIImage?) {
        self.previewImage = image
    }

    // MARK: - private variables

    private let network: Networking
    private let disposeBag = DisposeBag()
}
