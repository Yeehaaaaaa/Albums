//
//  User.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {

  // *********************************************************************
  // MARK: - Properties
  var id: Int
  var username: String
  var name: String
  var email: String

  // *********************************************************************
  // MARK: - LifeCycle
  init(id: Int, username: String, name: String, email: String) {
    self.id = id
    self.username = username
    self.name = name
    self.email = email
  }

  convenience required init(json: JSON) {

    let id = json["id"].intValue,
    username = json["username"].stringValue,
    email = json["email"].stringValue,
    name = json["name"].stringValue

    self.init(id: id, username: username, name: name, email: email)
  }

  // *********************************************************************
  // MARK: - Array
  static func getUsers(_ json: JSON) -> [User] {
    var users: [User] = []

    for (_, index) in json {
      let user = User(json: index)
      users.append(user)
    }
    return users
  }
}
