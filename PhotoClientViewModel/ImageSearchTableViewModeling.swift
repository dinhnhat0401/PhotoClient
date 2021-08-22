//
//  ImageSearchTableViewModeling.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import PhotoClientModel
import RxSwift
import RxCocoa

public protocol ImageSearchTableViewModeling {
    var imageEntities: [ImageEntity]? { get }
    var network: Networking { get }

    func startSearch() -> Observable<[ImageSearchTableViewCellModeling]>
}
