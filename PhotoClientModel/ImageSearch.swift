//
//  ImageSearch.swift
//  PhotoClientModel
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import RxSwift
import SwiftyJSON

public final class ImageSearch: ImageSearching {
    public init(network: Networking) {
        self.network = network
    }

    public func searchImages() -> Observable<ResponseEntity> {
        let url = Pixabay.apiURL
        let parameters = Pixabay.requestParameters
        return Observable.create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(NetworkError.NotReachedServer)
                return Disposables.create()
            }

            return self.network.requestJSON(url: url, parameters: parameters)
                .subscribe(onNext: { (json) in
                    if let response = try? ResponseEntity.decode(JSON(json)) {
                        observer.onNext(response)
                        return
                    }

                    observer.onError(NetworkError.IncorrectDataReturned)
                }, onError: { (e) in
                    observer.onError(e)
                })
        }
    }

    // MARK: - private variables

    private let network: Networking
    private let disposeBag = DisposeBag()
}
