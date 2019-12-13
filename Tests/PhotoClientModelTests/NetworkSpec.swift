//
//  NetworkSpec.swift
//  PhotoClientModel
//
//  Created by Dinh, Nhat | Nate | MPB on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import Alamofire
@testable import PhotoClientModel

class NetworkSpec: QuickSpec {
    override func spec() {
        var network: Network!
        beforeEach {
            network = Network()
        }

        describe("JSON") {
            it("eventually gets JSON data as specified with parameters.") {
                var json: [String: Any]? = nil
                let url = "https://httpbin.org/get"
                network.requestJSON(url: url, parameters: ["a": "b", "x": "y"])
                    .subscribe(onNext: {
                        json = $0 as? [String: Any]
                    }).disposed(by: self.disposeBag)

                expect(json).toEventuallyNot(beNil(), timeout: 5)
                expect((json?["args"] as? [String: AnyObject])?["a"] as? String)
                    .toEventually(equal("b"), timeout: 5)
                expect((json?["args"] as? [String: AnyObject])?["x"] as? String)
                    .toEventually(equal("y"), timeout: 5)
            }

            it("eventually gets an error if the network has a problem.") {
                var error: NetworkError? = nil
                let url = "https://not.existing.server.comm/get"
                network.requestJSON(url: url, parameters: ["a": "b", "x": "y"])
                    .subscribe ({ (e) in
                        error = e.error as? NetworkError
                    }).disposed(by: self.disposeBag)

                expect(error).toEventually(equal(NetworkError.Unknown), timeout: 5)
            }
        }

        describe("Image") {
            it("eventually gets an image.") {
                var image: UIImage?
                network
                    .requestImage(url: "https://httpbin.org/image/jpeg")
                    .subscribe(onNext: {
                        image = $0
                    }).disposed(by: self.disposeBag)
                expect(image).toEventuallyNot(beNil(), timeout: 5)
            }

            it("eventually gets an error if incorrect data for an image is returned.") {
                var error: NetworkError?
                network.requestImage(url: "https://httpbin.org/get")
                    .subscribe ({ (e) in
                        error = e.error as? NetworkError
                    }).disposed(by: self.disposeBag)

               expect(error).toEventually(equal(NetworkError.IncorrectDataReturned), timeout: 5)
            }

            it("eventually gets an error if the network has a problem.") {
                var error: NetworkError? = nil
                network.requestImage(url: "https://not.existing.server.comm/image/jpeg")
                    .subscribe ({ (e) in
                        error = e.error as? NetworkError
                    }).disposed(by: self.disposeBag)

                expect(error).toEventually(equal(NetworkError.Unknown), timeout: 5)
            }
        }
    }

    private let disposeBag = DisposeBag()
}
