//
//  ResponseEntity.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import SwiftyJSON

public struct ResponseEntity {
    public let totalCount: Int64
    public let images: [ImageEntity]
}

// MARK: Decodable
extension ResponseEntity: Decodable {
    public static func decode(_ e: JSON) throws -> ResponseEntity {
        guard let totalHits = e["totalHits"].int64, let imagesJson = e["hits"].array else {
            throw NetworkError.IncorrectDataReturned
        }

        var images = [ImageEntity]()
        for json in imagesJson {
            images.append(try ImageEntity.decode(json))
        }

        return ResponseEntity(
            totalCount: totalHits,
            images: images
        )
    }
}
