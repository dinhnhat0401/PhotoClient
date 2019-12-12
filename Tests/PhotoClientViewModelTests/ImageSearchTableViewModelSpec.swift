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

    // MARK: spec

    override func spec() {
        var viewModel: ImageSearchTableViewModel!
        beforeEach {
            viewModel = ImageSearchTableViewModel(imageSearch: StubImageSearch())
        }

        it("eventually sets cellModels property after the search.") {
//            var cellModels: [ImageSearchTableViewCellModeling]? = nil

//            viewModel.cellModels.producer
//                .on(next: { cellModels = $0 })
//                .start()
            var cellModels: [ImageSearchTableViewCellModeling] = []
            viewModel.cellModels.subscribe { (e) in
                cellModels = e.element ?? []
            }.disposed(by: DisposeBag())

            expect(cellModels).toEventuallyNot(beNil())
            expect(cellModels.count).toEventually(equal(2))
            expect(cellModels[0].id).toEventually(equal(10000))
            expect(cellModels[1].id).toEventually(equal(10001))
        }
//        it("sets cellModels property on the main thread.") {
//            var onMainThread = false
//            viewModel.cellModels.producer
//                .on(next: { _ in onMainThread = NSThread.isMainThread() })
//                .start()
//            viewModel.startSearch()
//
//            expect(onMainThread).toEventually(beTrue())
//        }
    }
}
