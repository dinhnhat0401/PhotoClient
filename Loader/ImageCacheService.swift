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
    var mem = [URL: UIImage]()
    func get(url: URL) -> UIImage? {
        return mem[url]
    }

    func set(url: URL, image: UIImage) {
        mem[url] = image
    }
}
