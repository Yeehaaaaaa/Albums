//
//  Album.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import SwiftyJSON

class Album {

  // *********************************************************************
  // MARK: - Properties
  var id: Int
  var userId: Int
  var title: String

  // *********************************************************************
  // MARK: - LifeCycle
  init(id: Int, userId: Int, title: String) {
    self.id = id
    self.userId = userId
    self.title = title
  }

  convenience required init(json: JSON) {

    let id = json["id"].intValue,
    userId = json["userId"].intValue,
    title = json["title"].stringValue

    self.init(id: id, userId: userId, title: title)
  }

  // *********************************************************************
  // MARK: - Array
  static func getAlbums(_ json: JSON) -> [Album] {
    var albums: [Album] = []

    for (_, index) in json {
      let album = Album(json: index)
      albums.append(album)
    }
    return albums
  }
}
