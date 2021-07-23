//
//  Networking.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import RxSwift
import UIKit

public protocol Networking {
    func requestJSON(url: String, parameters: [String: Any]?) -> Observable<Any>
    func requestImage(url: String) -> Observable<UIImage>
    func cancelRequestImage(url: String)
}
