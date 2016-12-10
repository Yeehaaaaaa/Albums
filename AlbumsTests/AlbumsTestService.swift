//
//  AlbumsTestService.swift
//  Albums
//
//  Created by Arthur Daurel on 10/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import SwiftyJSON

let FILE_NAME = "User"

class AlbumsTestService: AlbumsServiceProtocol {

  func getUsers(completion: @escaping (Result<[User]>) -> Void) {

    do {
      let object = try JSONSerialization.jsonObject(with: Utils.readJsonFile(FILE_NAME)!, options: .allowFragments)
      let json = JSON(object)
      let users = User.getUsers(json)

      completion(Result.success(users))
    } catch {}
  }

  func getAlbums(_ userId: Int, completion: @escaping (Result<[Album]>) -> Void) {
  }

  func getThumbnails(_ userId: Int, completion: @escaping (Result<[Thumbnail]>) -> Void) {
  }
}
