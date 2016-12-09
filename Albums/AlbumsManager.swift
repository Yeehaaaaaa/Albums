//
//  AlbumsManager.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

protocol AlbumsManagerProtocol: class {

  func fetchUser(completion: @escaping (Result<[User]>) -> Void)
}

class AlbumsManager: AlbumsManagerProtocol {

  // *********************************************************************
  // MARK: - Service
  fileprivate var albumsService: AlbumsServiceProtocol!

  // *********************************************************************
  // MARK: - Properties
  fileprivate var isFetchingUsers = false

  // *********************************************************************
  // MARK: - Init
  init(service: AlbumsServiceProtocol) {
    self.albumsService = service
  }

  convenience init() {
    self.init(service: AlbumsService())
  }

  // *********************************************************************
  // MARK: - User
  func fetchUser(completion: @escaping (Result<[User]>) -> Void) {

    if isFetchingUsers {
      completion(Result.failure(RequestError.requestAlreadyStart))
    }

    isFetchingUsers = true

    albumsService.getUsers() { [weak self] result in
      guard let `self` = self else { return }

      self.isFetchingUsers = false
      completion(result)
    }
  }
}
