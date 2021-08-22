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

        let item = DispatchWorkItem {
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

        jobs[url] = item
        queue.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 500 * NSEC_PER_MSEC), execute: item)
    }

    func cancel(url: URL) {
        jobs[url]?.cancel()
    }

    // MARK: - private variables

    private let queue = DispatchQueue(label: "com.nate.Loader.ImageRequestService", qos: .userInitiated)
    private var jobs = [URL: DispatchWorkItem]()
}
