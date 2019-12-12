//
//  ImageSearchTableViewCellModelSpec.swift
//  PhotoClientModel
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Quick
import Nimble
@testable import PhotoClientModel
@testable import PhotoClientViewModel

class ImageSearchTableViewCellModelSpec: QuickSpec {
    override func spec() {
        it("sets id.") {
            let viewModel = ImageSearchTableViewCellModel(image: dummyResponse.images[0])

            expect(viewModel.id).toEventually(equal(10000))
        }

        it("formats tag and page image size texts.") {
            let viewModel = ImageSearchTableViewCellModel(image: dummyResponse.images[0])

            expect(viewModel.pageImageSizeText).toEventually(equal("1000 x 2000"))
            expect(viewModel.tagText).toEventually(equal("a, b"))
        }
    }
}
