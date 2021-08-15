//
//  ImageDetailsCollectionViewCellModel.swift
//  PhotoClientViewModel
//
//  Created by Đinh Văn Nhật on 2021/08/14.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import PhotoClientModel
import RxSwift
import UIKit

public protocol ImageDetailsCollectionViewCellModeling {
//    var userAvatarImage: UIImage { get }
    var imageURL: String { get }
    var usernameText: String { get }
    var viewCountText: String { get }
    var downloadCountText: String { get }
    var likeCountText: String { get }

    func getImage() -> Observable<UIImage>
}

internal final class ImageDetailsCollectionViewCellModel: ImageDetailsCollectionViewCellModeling {

    init(_ entity: ImageEntity, _ networking: Networking) {
        self.imageURL = entity.imageURL
        self.usernameText = entity.username
        self.viewCountText = "\(entity.viewCount) times"
        self.downloadCountText = "\(entity.downloadCount) times"
        self.likeCountText = "\(entity.likeCount) times"

        self.network = networking
    }

    public func getImage() -> Observable<UIImage> {
        if let image = image {
            return Observable.just(image)
        }

        return network.requestImage(url: self.imageURL).map { (image) -> UIImage in
            self.image = image
            return image
        }
    }

    // MARK: - private variables

    internal var imageURL: String
//    var userAvatarImage: UIImage
    internal var usernameText: String
    internal var viewCountText: String
    internal var downloadCountText: String
    internal var likeCountText: String

    private var image: UIImage?
    private var network: Networking
}
