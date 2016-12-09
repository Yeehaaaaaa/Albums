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
}

class AlbumsService: AlbumsServiceProtocol {

  // *********************************************************************
  // MARK: - Enum
  fileprivate enum RootURL: String {
    case users = "users"

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
        print(json)
        let user = User(json: json)
        completion(Result.success(user))
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }
}
