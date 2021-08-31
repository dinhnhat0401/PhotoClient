//
//  ImageCacheService.swift
//  Loader
//
//  Created by Đinh Văn Nhật on 2021/07/21.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheService {
    var imageCache = NSCache<NSURL, UIImage>()
    func get(url: URL) -> UIImage? {
        return imageCache.object(forKey: url as NSURL)
    }

    func set(url: URL, image: UIImage) {
        imageCache.setObject(image, forKey: url as NSURL)
    }
}
