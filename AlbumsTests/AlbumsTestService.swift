//
//  AlbumsTestService.swift
//  Albums
//
//  Created by Arthur Daurel on 10/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import SwiftyJSON

var FILE_NAME = "User"

class AlbumsTestService: AlbumsServiceProtocol {

  func getUsers(completion: @escaping (Result<[User]>) -> Void) {

    do {
      if let data = Utils.readJsonFile(FILE_NAME) {
        let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let json = JSON(object)
        let users = User.getUsers(json)

        completion(Result.success(users))
        return
      }
      completion(Result.failure(RequestError.invalidJson))
    } catch {}
  }

  func getAlbums(_ userId: Int, completion: @escaping (Result<[Album]>) -> Void) {

    do {
      if let data = Utils.readJsonFile(FILE_NAME) {
        let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let json = JSON(object)
        let albums = Album.getAlbums(json)

        completion(Result.success(albums))
        return
      }
      completion(Result.failure(RequestError.invalidJson))
    } catch {}
  }

  func getThumbnails(_ userId: Int, completion: @escaping (Result<[Thumbnail]>) -> Void) {

    do {
      if let data = Utils.readJsonFile(FILE_NAME) {
        let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let json = JSON(object)
        let thumbnails = Thumbnail.getThumbnails(json)

        completion(Result.success(thumbnails))
        return
      }
      completion(Result.failure(RequestError.invalidJson))
    } catch {}
  }
}
