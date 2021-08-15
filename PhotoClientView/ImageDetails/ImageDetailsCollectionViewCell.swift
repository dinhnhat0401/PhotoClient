//
//  ImageDetailsCollectionViewCell.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2021/08/14.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import PhotoClientViewModel
import UIKit
import RxSwift

final class ImageDetailsCollectionViewCell: UICollectionViewCell {

    static var identifier = "ImageDetailsCollectionViewCell"

    var viewModel: ImageDetailsCollectionViewCellModeling? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            self.usernameLabel.text = viewModel.usernameText

            self.viewCountLabel.text = viewModel.viewCountText
            self.downloadCountLabel.text = viewModel.downloadCountText
            self.likeCountLabel.text = viewModel.likeCountText
        }
    }

    internal func getImage() {
        guard let viewModel = self.viewModel else {
            return
        }

        viewModel.getImage().observe(on: MainScheduler.instance).subscribe { (image) in
            self.imageView.image = image
        }.disposed(by: disposeBag)
    }

    // MARK: - private var

    @IBOutlet private var userAvatarImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var viewCountLabel: UILabel!
    @IBOutlet private var downloadCountLabel: UILabel!
    @IBOutlet private var likeCountLabel: UILabel!

    private var disposeBag = DisposeBag()
}
