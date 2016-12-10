//
//  AlbumsTests.swift
//  AlbumsTests
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import XCTest
@testable import Albums

class AlbumsTests: XCTestCase {

  override func setUp() {
    super.setUp()

    AppManager.sharedInstance.setUpDependencyInjectionTesting()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testUser() {

    let asyncExpectation = expectation(description: "userCompletionFunction")
    var testUsers: [User]?

    let albumsManager = AppManager.sharedInstance.container.resolve(AlbumsManagerProtocol.self)

    albumsManager?.fetchUser() { result in

      switch result {

      case .success(let tmp):
        testUsers = tmp

      case .failure: ()
      }
      asyncExpectation.fulfill()
    }

    self.waitForExpectations(timeout: 5) { error in

      XCTAssert(testUsers[0].name == "Leanne Graham", "Test name user[0]")
    }
  }
}
