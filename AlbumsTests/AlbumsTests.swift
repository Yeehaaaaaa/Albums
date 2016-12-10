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

  // *********************************************************************
  // MARK: - Users
  func testUsers() {

    FILE_NAME = "User"

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

      XCTAssert(testUsers != nil, "Test users nil")

      XCTAssert(testUsers?[0].name == "Leanne Graham", "Test name user[0]")
      XCTAssert(testUsers?[9].name == "Clementina DuBuque", "Test name user[9]")
    }
  }

  func testUsersWithErrors() {

    FILE_NAME = "UserErrors"

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

      XCTAssert(testUsers != nil, "Test users nil")

      XCTAssert(testUsers?[0].name == "", "Test null name")
      XCTAssert(testUsers?[0].username == "", "Test username not return")
    }
  }

  // *********************************************************************
  // MARK: - Albums
  func testAlbums() {

    FILE_NAME = "Albums"

    let asyncExpectation = expectation(description: "albumsCompletionFunction")
    var testAlbums: [Album]?

    let albumsManager = AppManager.sharedInstance.container.resolve(AlbumsManagerProtocol.self)

    albumsManager?.fetchAlbum(0) { result in

      switch result {

      case .success(let tmp):
        testAlbums = tmp

      case .failure: ()
      }
      asyncExpectation.fulfill()
    }

    self.waitForExpectations(timeout: 5) { error in

      XCTAssert(testAlbums != nil, "Test albums nil")

      XCTAssert(testAlbums?[0].title == "quidem molestiae enim", "Test title[0]")
      XCTAssert(testAlbums?[0].userId == 1, "Test userId")
      XCTAssert(testAlbums?[0].id == 1, "Test id")
    }
  }

  func testAlbumsWithErrors() {

    FILE_NAME = "AlbumsErrors"

    let asyncExpectation = expectation(description: "albumsCompletionFunction")
    var testAlbums: [Album]?

    let albumsManager = AppManager.sharedInstance.container.resolve(AlbumsManagerProtocol.self)

    albumsManager?.fetchAlbum(0) { result in

      switch result {

      case .success(let tmp):
        testAlbums = tmp

      case .failure: ()
      }
      asyncExpectation.fulfill()
    }

    self.waitForExpectations(timeout: 5) { error in

      XCTAssert(testAlbums != nil, "Test albums nil")

      XCTAssert(testAlbums?[0].title == "", "Test title not return")
      XCTAssert(testAlbums?[0].id == 0, "Test id null")
    }
  }

  // *********************************************************************
  // MARK: - Thumbnails
  func testThumbnails() {

    FILE_NAME = "Thumbnails"

    let asyncExpectation = expectation(description: "thumbnailsCompletionFunction")
    var testThumbnails: [Thumbnail]?

    let albumsManager = AppManager.sharedInstance.container.resolve(AlbumsManagerProtocol.self)

    albumsManager?.fetchThumbnails(0) { result in

      switch result {

      case .success(let tmp):
        testThumbnails = tmp

      case .failure: ()
      }
      asyncExpectation.fulfill()
    }

    self.waitForExpectations(timeout: 5) { error in

      XCTAssert(testThumbnails != nil, "Test users nil")

      XCTAssert(testThumbnails?[0].id == 1, "Test id")
      XCTAssert(testThumbnails?[0].thumbnailUrl == "http://placehold.it/150/30ac17", "Test thumbnailUrl")
    }
  }

  func testThumbnailsWithErrors() {

    FILE_NAME = "ThumbnailsErrors"

    let asyncExpectation = expectation(description: "thumbnailsCompletionFunction")
    var testThumbnails: [Thumbnail]?

    let albumsManager = AppManager.sharedInstance.container.resolve(AlbumsManagerProtocol.self)

    albumsManager?.fetchThumbnails(0) { result in

      switch result {

      case .success(let tmp):
        testThumbnails = tmp

      case .failure: ()
      }
      asyncExpectation.fulfill()
    }

    self.waitForExpectations(timeout: 5) { error in

      XCTAssert(testThumbnails != nil, "Test users nil")

      XCTAssert(testThumbnails?[0].url == "", "Test url nil")
      XCTAssert(testThumbnails?[0].thumbnailUrl == "", "Test thumbnailURL not return")
    }
  }
}
