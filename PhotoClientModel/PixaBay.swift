//
//  PixaBay.swift
//  PhotoClientModel
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

internal struct Pixabay {
    internal static let apiURL = "https://pixabay.com/api/"

    internal static var requestParameters: [String: Any] {
        return [
            "key": Config.apiKey, // Fill with your own API key.
            "image_type": "photo",
            "safesearch": true,
            "per_page": 50,
        ]
    }
}
