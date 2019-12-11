//
//  ImageSearching.swift
//  PhotoClientModel
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import RxSwift

public protocol ImageSearching {
    func searchImages() -> Observable<ResponseEntity>
}
