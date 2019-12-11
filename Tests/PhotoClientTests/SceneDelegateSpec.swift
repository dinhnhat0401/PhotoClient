//
//  SceneDelegateSpec.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/12.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import Quick
import Nimble
import Swinject
import PhotoClientModel
import PhotoClientViewModel
import PhotoClientView
@testable import PhotoClient

class SceneDelegateSpec: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = SceneDelegate().container
        }

        describe("Container") {
            it("resolves every service type.") {
                // Models
                expect(container.resolve(Networking.self)).notTo(beNil())
                expect(container.resolve(ImageSearching.self)).notTo(beNil())

                // View models
                expect(container.resolve(ImageSearchTableViewModeling.self)).notTo(beNil())
            }

            it("injects view models to views.") {
                expect(container.resolve(ImageSearchTableViewController.self)).notTo(beNil())
            }
        }
    }
}
