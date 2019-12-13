//
//  Network.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

public final class Network: Networking {

    private let queue = DispatchQueue(label: "photoclient.Network.Queue")

    public init() {
    }

    public func requestJSON(url: String, parameters: [String : Any]?) -> Observable<Any> {
        return Observable.create { (observer) -> Disposable in
            AF.request(url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil,
                       interceptor: nil
            ).responseJSON(queue: self.queue) { (response) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(NetworkError(error: error as NSError))
                }
            }

            return Disposables.create()
        }
    }

    public func requestImage(url: String) -> Observable<UIImage> {
        return Observable.create { (observer) -> Disposable in
            let serializer = DataResponseSerializer.init()
            AF.request(url,
                       method: .get)
                .response(queue: self.queue, responseSerializer: serializer) { (response) in
                    switch response.result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            observer.onError(NetworkError.IncorrectDataReturned)
                            return
                        }
                        observer.onNext(image)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(NetworkError(error: error as NSError))
                    }
            }

            return Disposables.create()
        }.observeOn(MainScheduler.instance)
    }
}
