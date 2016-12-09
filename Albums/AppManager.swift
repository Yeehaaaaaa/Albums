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
  var users: User?

  fileprivate init() {}

  func setUpDependencyInjection() {

    // User dependence
    container.register(AlbumsServiceProtocol.self) { _ in AlbumsService() }
    container.register(AlbumsManagerProtocol.self) { r in
      AlbumsManager(service: r.resolve(AlbumsServiceProtocol.self)!)
    }
  }
}
