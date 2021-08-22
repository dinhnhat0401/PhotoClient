//
//  ImageSearchTableViewCellModeling.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import RxSwift
import UIKit

public protocol ImageSearchTableViewCellModeling {
    var id: UInt64 { get }
    var pageImageSizeText: String { get }
    var tagText: String { get }

    func getPreviewImage() -> Observable<UIImage?>
    func setPreviewImage(_ image: UIImage?)
}
