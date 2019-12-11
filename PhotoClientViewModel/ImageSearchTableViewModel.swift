//
//  ImageSearchTableViewModel.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import PhotoClientModel

public final class ImageSearchTableViewModel: ImageSearchTableViewModeling {
    private let imageSearch: ImageSearching

    public init(imageSearch: ImageSearching) {
        self.imageSearch = imageSearch
    }
}
