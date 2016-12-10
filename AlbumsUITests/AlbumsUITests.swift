//
//  AlbumsUITests.swift
//  AlbumsUITests
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import XCTest

class AlbumsUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testUsers() {
    
    let app = XCUIApplication()
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Username: Bret"].tap()
    
    let usersButton = app.navigationBars["Albums"].buttons["Users"]
    usersButton.tap()
    tablesQuery.staticTexts["Username: Antonette"].tap()
    usersButton.tap()
  }

  func testAlbums() {
    
    let app = XCUIApplication()
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Email: Sincere@april.biz"].tap()
    tablesQuery.staticTexts["quidem molestiae enim"].tap()
    
    let albumsButton = app.navigationBars["Thumbnails"].buttons["Albums"]
    albumsButton.tap()
    tablesQuery.staticTexts["natus impedit quibusdam illo est"].tap()
    albumsButton.tap()
    tablesQuery.staticTexts["distinctio laborum qui"].tap()
    albumsButton.tap()
  }

  func testThumbnails() {

    let app = XCUIApplication()
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Email: Sincere@april.biz"].tap()
    tablesQuery.staticTexts["quidem molestiae enim"].tap()
    
    let collectionViewsQuery = app.collectionViews
    let image = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).otherElements.children(matching: .image).element
    image.swipeLeft()
    
    let image2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).otherElements.children(matching: .image).element
    image2.swipeLeft()
    image2.swipeLeft()
    image2.swipeLeft()
    image.swipeLeft()
    
    let albumsButton = app.navigationBars["Thumbnails"].buttons["Albums"]
    albumsButton.tap()
    tablesQuery.staticTexts["natus impedit quibusdam illo est"].tap()
    image.swipeLeft()
    image2.swipeLeft()
    image.swipeLeft()
    albumsButton.tap()
  }
}
