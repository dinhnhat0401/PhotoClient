//
//  ImageSearchTableViewModeling.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol ImageSearchTableViewModeling {
    var cellModels: Observable<[ImageSearchTableViewCellModeling]> { get }
//    func startSearch()
}
