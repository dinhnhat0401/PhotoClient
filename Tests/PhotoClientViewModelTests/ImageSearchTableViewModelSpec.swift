//
//  ImageSearchTableViewModelSpec.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import PhotoClientModel
@testable import PhotoClientViewModel

class ImageSearchTableViewModelSpec: QuickSpec {

    // MARK: stub

    class StubImageSearch: ImageSearching {
        func searchImages() -> Observable<ResponseEntity> {
            return Observable.create { (observer) -> Disposable in
                observer.onNext(dummyResponse)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }

    class StubNetwork: Networking {
        func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
            return Observable.create { (observable) -> Disposable in
                observable.onCompleted()

                return Disposables.create()
            }
        }

        func requestImage(url: String) -> Observable<UIImage> {
            return Observable.create { (observable) -> Disposable in
                observable.onCompleted()

                return Disposables.create()
            }
        }
    }

    // MARK: spec

    override func spec() {
        var viewModel: ImageSearchTableViewModel!
        beforeEach {
            viewModel = ImageSearchTableViewModel(imageSearch: StubImageSearch(), network: StubNetwork())
        }

        it("eventually sets cellModels property after the search.") {
            viewModel.startSearch()
            var cellModels: [ImageSearchTableViewCellModeling] = []
            viewModel.cellModels.subscribe(onNext: { (models) in
                cellModels = models
                }).disposed(by: DisposeBag())

            expect(cellModels).toEventuallyNot(beNil())
            expect(cellModels.count).toEventually(equal(2))
            expect(cellModels[0].id).toEventually(equal(10000))
            expect(cellModels[1].id).toEventually(equal(10001))
        }

        it("sets cellModels property on the main thread.") {
            var onMainThread = false
            viewModel.startSearch()
            viewModel.cellModels.subscribe(onNext: { (models) in
                onMainThread = Thread.isMainThread
                }).disposed(by: DisposeBag())
            
            expect(onMainThread).toEventually(beTrue())
        }
    }
}
