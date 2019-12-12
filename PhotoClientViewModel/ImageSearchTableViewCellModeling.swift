//
//  ImageSearchTableViewCellModeling.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

public protocol ImageSearchTableViewCellModeling {
    var id: UInt64 { get }
    var pageImageSizeText: String { get }
    var tagText: String { get }
}
