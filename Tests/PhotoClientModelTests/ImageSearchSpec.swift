//
//  ImageSearchSpec.swift
//  PhotoClientModel
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import PhotoClientModel

class ImageSearchSpec: QuickSpec {

    // MARK: -  Stub

    class GoodStubNetwork: Networking {
        func requestJSON(url: String, parameters: [String: Any]?) -> Observable<Any> {
            var imageJSON0 = imageJSON
            imageJSON0["id"] = 0
            var imageJSON1 = imageJSON
            imageJSON1["id"] = 1
            let json: [String: Any] = [
                "totalHits": 123,
                "hits": [imageJSON0, imageJSON1]
            ]

            return Observable.create { (observer) -> Disposable in
                observer.onNext(json)
                observer.onCompleted()

                return Disposables.create()
            }
        }
    }

    class BadStubNetwork: Networking {
        func requestJSON(url: String, parameters: [String: Any]?) -> Observable<Any> {
            let json = [String: AnyObject]()
            return Observable.create { (observer) -> Disposable in
                observer.onNext(json)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }

    class ErrorStubNetwork: Networking {
        func requestJSON(url: String, parameters: [String: Any]?) -> Observable<Any> {
            return Observable.create { (observer) -> Disposable in
                observer.onError(NetworkError.NotConnectedToInternet)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }

    // MARK: - Spec

    override func spec() {
        it("returns images if the network works correctly.") {
            var response: ResponseEntity? = nil
            let search = ImageSearch(network: GoodStubNetwork())

            search.searchImages()
                .subscribe(onNext: {
                    response = $0
                }).disposed(by: self.disposeBag)

            expect(response).toEventuallyNot(beNil())
            expect(response?.totalCount).toEventually(equal(123))
            expect(response?.images.count).toEventually(equal(2))
            expect(response?.images[0].id).toEventually(equal(0))
            expect(response?.images[1].id).toEventually(equal(1))
        }

        it("sends an error if the network returns incorrect data.") {
            var error: NetworkError? = nil
            let search = ImageSearch(network: BadStubNetwork())

            search.searchImages()
                .subscribe ({ (e) in
                    error = e.error as? NetworkError
                }).disposed(by: self.disposeBag)

            expect(error).toEventually(equal(NetworkError.IncorrectDataReturned))
        }

        it("passes the error sent by the network.") {
            var error: NetworkError? = nil
            let search = ImageSearch(network: ErrorStubNetwork())
            search.searchImages()
                .subscribe ({ (e) in
                    error = e.error as? NetworkError
                }).disposed(by: self.disposeBag)

            expect(error).toEventually(equal(NetworkError.NotConnectedToInternet))
        }
    }

    // MARK: - private variables

    let disposeBag = DisposeBag()
}
