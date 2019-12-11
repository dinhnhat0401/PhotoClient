//
//  ResponseEntity.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Himotoki

public struct ResponseEntity {
    public let totalCount: Int64
    public let images: [ImageEntity]
}

// MARK: Decodable
extension ResponseEntity: Decodable {
    public static func decode(_ e: Extractor) throws -> ResponseEntity {
        return try ResponseEntity(
            totalCount: e <| "totalHits",
            images: e <| "hits"
        )
    }
}
