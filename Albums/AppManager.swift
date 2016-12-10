//
//  AppManager.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import Swinject

class AppManager {

  static let sharedInstance = AppManager()

  // *********************************************************************
  // MARK: - Properties
  let container = Container()

  fileprivate init() {}

  func setUpDependencyInjection() {

    container.register(AlbumsServiceProtocol.self) { _ in AlbumsService() }
    container.register(AlbumsManagerProtocol.self) { r in
      AlbumsManager(service: r.resolve(AlbumsServiceProtocol.self)!)
    }
  }

  func setUpDependencyInjectionTesting() {

    container.register(AlbumsServiceProtocol.self) { _ in AlbumsTestService() }
    container.register(AlbumsManagerProtocol.self) { r in
      AlbumsManager(service: r.resolve(AlbumsServiceProtocol.self)!)
    }
  }
}
