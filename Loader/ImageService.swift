//
//  ImageService.swift
//  Loader
//
//  Created by Đinh Văn Nhật on 2021/07/21.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import UIKit

public class ImageService {

    public init() {
        self.cache = ImageCacheService()
        self.request = ImageRequestService()
    }

    init(cache: ImageCacheService, request: ImageRequestService) {
        self.cache = cache
        self.request = request
    }

    public func load(url: URL, completed: @escaping ((UIImage?)->Void)) {
        if let image = self.cache.get(url: url) {
            completed(image)
            return
        }

        self.request.request(url: url) { (image) in
            if let image = image {
                self.cache.set(url: url, image: image)
            }
            completed(image)
        }
    }

    let cache: ImageCacheService
    let request: ImageRequestService
}
