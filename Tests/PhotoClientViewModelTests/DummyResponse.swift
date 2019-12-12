//
//  DummyResponse.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

@testable import PhotoClientModel
@testable import PhotoClientViewModel

let dummyResponse: ResponseEntity = {
    let image0 = ImageEntity(
        id: 10000,
        pageURL: "https://somewhere.com/page0/",
        pageImageWidth: 1000,
        pageImageHeight: 2000,
        previewURL: "https://somewhere.com/preview0.jpg",
        previewWidth: 250,
        previewHeight: 500,
        imageURL: "https://somewhere.com/image0.jpg",
        imageWidth: 100,
        imageHeight: 200,
        viewCount: 99,
        downloadCount: 98,
        likeCount: 97,
        tags: ["a", "b"],
        username: "User0")
    let image1 = ImageEntity(
        id: 10001,
        pageURL: "https://somewhere.com/page1/",
        pageImageWidth: 1500,
        pageImageHeight: 3000,
        previewURL: "https://somewhere.com/preview1.jpg",
        previewWidth: 350,
        previewHeight: 700,
        imageURL: "https://somewhere.com/image1.jpg",
        imageWidth: 150,
        imageHeight: 300,
        viewCount: 123456789,
        downloadCount: 12345678,
        likeCount: 1234567,
        tags: ["x", "y"],
        username: "User1")
    return ResponseEntity(totalCount: 123, images: [image0, image1])
}()

