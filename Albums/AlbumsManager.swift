//
//  AlbumsManager.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

protocol AlbumsManagerProtocol: class {
  var users: [User] { get set }

  func userPersistant() -> [User]
  func fetchUser(completion: @escaping (Result<[User]>) -> Void)
  func fetchAlbum(_ userId: Int, completion: @escaping (Result<[Album]>) -> Void)
  func fetchThumbnails(_ albumId: Int, completion: @escaping (Result<[Thumbnail]>) -> Void)
}

class AlbumsManager: AlbumsManagerProtocol {

  // *********************************************************************
  // MARK: - Service
  fileprivate var albumsService: AlbumsServiceProtocol!

  // *********************************************************************
  // MARK: - Properties
  var users = [User]()

  fileprivate var isFetchingUsers = false
  fileprivate var isFetchingAlbums = false
  fileprivate var isFetchingThumbnails = false

  // *********************************************************************
  // MARK: - Init
  init(service: AlbumsServiceProtocol) {
    self.albumsService = service
  }

  convenience init() {
    self.init(service: AlbumsService())
  }

  // *********************************************************************
  // MARK: - Publics
  func userPersistant() -> [User] {

    self.users = User.getPersistantUser()
    return users
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

  // *********************************************************************
  // MARK: - Album
  func fetchAlbum(_ userId: Int, completion: @escaping (Result<[Album]>) -> Void) {

    if isFetchingAlbums {
      completion(Result.failure(RequestError.requestAlreadyStart))
    }

    isFetchingAlbums = true

    albumsService.getAlbums(userId) { [weak self] result in
      guard let `self` = self else { return }

      self.isFetchingAlbums = false
      completion(result)
    }
  }

  // *********************************************************************
  // MARK: - Thumbnails
  func fetchThumbnails(_ albumId: Int, completion: @escaping (Result<[Thumbnail]>) -> Void) {

    if isFetchingThumbnails {
      completion(Result.failure(RequestError.requestAlreadyStart))
    }

    isFetchingThumbnails = true

    albumsService.getThumbnails(albumId) { [weak self] result in
      guard let `self` = self else { return }

      self.isFetchingThumbnails = false
      completion(result)
    }
  }
}
