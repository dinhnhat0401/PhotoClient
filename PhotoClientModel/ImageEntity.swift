//
//  ImageEntity.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import SwiftyJSON

public struct ImageEntity {
    public let id: UInt64

    public let pageURL: String
    public let pageImageWidth: Int
    public let pageImageHeight: Int

    public let previewURL: String
    public let previewWidth: Int
    public let previewHeight: Int

    public let imageURL: String
    public let imageWidth: Int
    public let imageHeight: Int

    public let viewCount: Int64
    public let downloadCount: Int64
    public let likeCount: Int64
    public let tags: [String]
    public let username: String
}

// MARK: Decodable
extension ImageEntity: Decodable {
    public static func decode(_ e: JSON) throws -> ImageEntity {
        let splitCSV: (String) -> [String] = { csv in
            csv
                .split { $0 == "," }
                .map {
                    String($0).trimmingCharacters(
                        in: NSCharacterSet.whitespaces)
                }
        }

        let tags = e["tags"].string.map(splitCSV) ?? []
        guard let id = e["id"].uInt64,
              let pageURL = e["pageURL"].string,
              let pageImageWith = e["imageWidth"].int,
              let pageImageHeight = e["imageHeight"].int,
              let previewURL = e["previewURL"].string,
              let previewWidth = e["previewWidth"].int,
              let previewHeight = e["previewHeight"].int,
              let imageURL = e["webformatURL"].string,
              let imageWidth = e["webformatWidth"].int,
              let imageHeight = e["webformatHeight"].int,
              let viewCount = e["views"].int64,
              let downloadCount = e["downloads"].int64,
              let likeCount = e["likes"].int64,
              let username = e["user"].string else {
            throw NetworkError.IncorrectDataReturned
        }

        return ImageEntity(
            id: id,

            pageURL: pageURL,
            pageImageWidth: pageImageWith,
            pageImageHeight: pageImageHeight,

            previewURL: previewURL,
            previewWidth: previewWidth,
            previewHeight: previewHeight,

            imageURL: imageURL,
            imageWidth: imageWidth,
            imageHeight: imageHeight,

            viewCount: viewCount,
            downloadCount: downloadCount,
            likeCount: likeCount,
            tags: tags,
            username: username
        )
    }
}
