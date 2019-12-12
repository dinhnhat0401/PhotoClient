//
//  ImageSearchTableViewCell.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import UIKit
import PhotoClientViewModel
import SnapKit

internal final class ImageSearchTableViewCell: UITableViewCell {
    static let identifier = "ImageSearchTableViewCell"

    internal var viewModel: ImageSearchTableViewCellModeling? {
        didSet {
            tagLabel.text = viewModel?.tagText
            imageSizeLabel.text = viewModel?.pageImageSizeText
        }
    }

    var previewImageView = UIImageView()
    var tagLabel = UILabel()
    var imageSizeLabel = UILabel()

//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init()
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(previewImageView)
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(imageSizeLabel)

        previewImageView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.bottom.equalTo(self.contentView)
            maker.leading.equalTo(self.contentView)
            maker.width.equalTo(100.0)
        }

        tagLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.trailing.equalTo(self.contentView)
            maker.leading.equalTo(self.previewImageView.snp.trailing)
            maker.height.equalTo(40.0)
        }

        imageSizeLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.tagLabel)
            maker.bottom.trailing.equalTo(self.contentView)
            maker.leading.equalTo(self.previewImageView.snp.trailing)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
