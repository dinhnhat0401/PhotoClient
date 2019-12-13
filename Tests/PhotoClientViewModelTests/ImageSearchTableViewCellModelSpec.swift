//
//  ImageSearchTableViewCellModelSpec.swift
//  PhotoClientModel
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import PhotoClientModel
@testable import PhotoClientViewModel

class ImageSearchTableViewCellModelSpec: QuickSpec {
    // MARK: Stubs
    class StubNetwork: Networking {
        func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
            return Observable.create { (observable) -> Disposable in
                observable.onCompleted()
                return Disposables.create()
            }
        }

        func requestImage(url: String) -> Observable<UIImage> {
            return Observable.create { (observable) -> Disposable in
                observable.onNext(image1x1)
                return Disposables.create()
            }.observeOn(CurrentThreadScheduler.instance)
        }
    }

    class ErrorStubNetwork: Networking {
        func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
            return Observable.create { (observable) -> Disposable in
                observable.onCompleted()
                return Disposables.create()
            }
        }

        func requestImage(url: String) -> Observable<UIImage> {
            return Observable.create { (observable) -> Disposable in
                observable.onError(NetworkError.IncorrectDataReturned)
                return Disposables.create()
            }
        }
    }

    override func spec() {
        var viewModel: ImageSearchTableViewCellModel!
        beforeEach {
            viewModel = ImageSearchTableViewCellModel(
                image: dummyResponse.images[0],
                network: StubNetwork())
        }

        describe("Constant values") {
            it("sets id.") {
                expect(viewModel.id).toEventually(equal(10000))
            }
            it("formats tag and page image size texts.") {
                expect(viewModel.pageImageSizeText)
                    .toEventually(equal("1000 x 2000"))
                expect(viewModel.tagText).toEventually(equal("a, b"))
            }
        }

        describe("Preview image") {
//            it("returns nil at the first time.") {
//                var image: UIImage? = image1x1
//                viewModel.getPreviewImage()
//                    .subscribe(onNext: {
//                        image = $0
//                    }).disposed(by: self.disposeBag)
//
//                expect(image).toEventually(beNil())
//            }

            it("eventually returns an image.") {
                var image: UIImage? = nil
                viewModel.getPreviewImage()
                    .subscribe(onNext: {
                        image = $0
                    }).disposed(by: self.disposeBag)

                expect(image).toEventuallyNot(beNil())
            }

            it("returns an image on the main thread.") {
                var onMainThread = false
                viewModel.getPreviewImage()
                    .subscribe { (_) in
                        onMainThread = Thread.isMainThread
                }.disposed(by: self.disposeBag)

                expect(onMainThread).toEventually(beTrue())
            }

            context("with an image already downloaded") {
                it("immediately returns the image omitting the first nil.") {
                    var image: UIImage? = nil
                    viewModel.getPreviewImage()
                        .subscribe(onNext: {
                            image = $0
                        }).disposed(by: self.disposeBag)

                    expect(image).toEventuallyNot(beNil())
                }
            }

            context("on error") {
                it("returns nil.") {
                    var image: UIImage? = image1x1
                    let viewModel = ImageSearchTableViewCellModel(
                        image: dummyResponse.images[0],
                        network: ErrorStubNetwork())
                    viewModel.getPreviewImage()
                        .subscribe(onNext: {
                            image = $0
                        }, onError: { _ in
                            image = nil
                        }).disposed(by: self.disposeBag)

                    expect(image).toEventually(beNil())
                }
            }
        }
    }

    // MARK: - private variables

    private let disposeBag = DisposeBag()
}
