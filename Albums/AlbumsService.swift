//
//  AlbumsService.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

protocol AlbumsServiceProtocol: class {

  func getUsers(completion: @escaping (Result<[User]>) -> Void)
  func getAlbums(_ userId: Int, completion: @escaping (Result<[Album]>) -> Void)
  func getThumbnails(_ userId: Int, completion: @escaping (Result<[Thumbnail]>) -> Void)
}

class AlbumsService: AlbumsServiceProtocol {

  // *********************************************************************
  // MARK: - Enum
  fileprivate enum RootURL: String {
    case users = "users/"
    case album = "albums"
    case thumbnail = "photos"

    var string: String {
      return self.rawValue
    }
  }

  // *********************************************************************
  // MARK: - Users
  func getUsers(completion: @escaping (Result<[User]>) -> Void) {

    let requestParameters = RequestParameters(method: .get, url: RootURL.users.string, parameters: [:])

    Network().request(requestParameters) { result in
      switch result {
      case .success(let json):
        let users = User.getUsers(json)
        completion(Result.success(users))
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }

  // *********************************************************************
  // MARK: - Album
  func getAlbums(_ userId: Int, completion: @escaping (Result<[Album]>) -> Void) {

    let url = RootURL.users.string + String(userId) + "/" + RootURL.album.string
    let requestParameters = RequestParameters(method: .get, url: url, parameters: [:])

    Network().request(requestParameters) { result in
      switch result {
      case .success(let json):
        let albums = Album.getAlbums(json)
        completion(Result.success(albums))
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }

  // *********************************************************************
  // MARK: - Thumbnails
  func getThumbnails(_ userId: Int, completion: @escaping (Result<[Thumbnail]>) -> Void) {

    let url = RootURL.album.string + String(userId) + "/" + RootURL.thumbnail.string
    let requestParameters = RequestParameters(method: .get, url: url, parameters: [:])

    Network().request(requestParameters) { result in
      switch result {
      case .success(let json):
        print(json)
        let thumbnails = Thumbnail.getThumbnails(json)
        completion(Result.success(thumbnails))
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }
}
