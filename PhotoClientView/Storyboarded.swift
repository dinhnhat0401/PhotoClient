//
//  Storyboarded.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2021/08/14.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(_ storyboardName: String) -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardName: String) -> Self? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self
    }
}
