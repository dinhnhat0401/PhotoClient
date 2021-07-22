//
//  ImageRequestService.swift
//  Loader
//
//  Created by Đinh Văn Nhật on 2021/07/21.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import UIKit

enum ImageRequestServiceError: Error {
    case incorrectData
}

class ImageRequestService {
    func request(url: URL, completed: @escaping ((UIImage?)->Void)) {
        let urlRequest = URLRequest(url: url, timeoutInterval: TimeInterval(10))
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completed(nil)
            }

            guard let data = data, let image = UIImage(data: data) else {
//                throw ImageRequestServiceError.incorrectData
                completed(nil)
                return
            }

            completed(image)
        }
        task.resume()
    }
}
