//
//  Network.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

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
                case .failure(let error):
                    observer.onError(NetworkError(error: error as NSError))
                }
            }

            return Disposables.create()
        }
    }
}
