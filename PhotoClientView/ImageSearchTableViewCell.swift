//
//  ImageSearchTableViewCell.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import PhotoClientViewModel
import RxSwift
import SnapKit
import UIKit

internal final class ImageSearchTableViewCell: UITableViewCell {
    static let identifier = "ImageSearchTableViewCell"
    static var count = 0
    internal var viewModel: ImageSearchTableViewCellModeling? {
        didSet {
            tagLabel.text = viewModel?.tagText
            imageSizeLabel.text = viewModel?.pageImageSizeText
        }
    }

    var previewImageView = UIImageView()
    var tagLabel = UILabel()
    var imageSizeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("called \(ImageSearchTableViewCell.count)")
        ImageSearchTableViewCell.count += 1
        previewImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(previewImageView)
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(imageSizeLabel)

        previewImageView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.contentView).offset(10.0)
            maker.bottom.equalTo(self.contentView).offset(-10.0)
            maker.leading.equalTo(self.contentView).offset(10.0)
            maker.width.equalTo(100.0)
        }

        tagLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.trailing.equalTo(self.contentView)
            maker.leading.equalTo(self.previewImageView.snp.trailing).offset(10.0)
            maker.height.equalTo(40.0)
        }

        imageSizeLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.tagLabel)
            maker.bottom.trailing.equalTo(self.contentView)
            maker.leading.equalTo(self.previewImageView.snp.trailing).offset(10.0)
        }
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.imageView?.image = nil
//    }

//    func getPreviewImage() {
//        self.viewModel?.getPreviewImage()
//            .subscribe(onNext: { [weak self] (image) in
//                if let image = image {
//                    print("called for image \(self?.viewModel?.id)")
//                    self?.previewImageView.image = image
//                    self?.viewModel?.setPreviewImage(image)
//                }
//            }).disposed(by: self.disposeBag)
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private variables

    private let disposeBag = DisposeBag()
}
