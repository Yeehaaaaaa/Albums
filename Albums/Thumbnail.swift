//
//  Thumbnail.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import SwiftyJSON

class Thumbnail {

  // *********************************************************************
  // MARK: - Properties
  var id: Int
  var albumId: Int
  var title: String
  var url: String
  var thumbnailUrl: String

  // *********************************************************************
  // MARK: - LifeCycle
  init(id: Int, albumId: Int, title: String, url: String, thumbnailUrl: String) {
    self.id = id
    self.albumId = albumId
    self.title = title
    self.url = url
    self.thumbnailUrl = thumbnailUrl
  }

  convenience required init(json: JSON) {

    let id = json["id"].intValue,
    albumId = json["albumId"].intValue,
    title = json["title"].stringValue,
    url = json["url"].stringValue,
    thumbnailUrl = json["thumbnailUrl"].stringValue

    self.init(id: id, albumId: albumId, title: title, url: url, thumbnailUrl: thumbnailUrl)
  }

  // *********************************************************************
  // MARK: - Array
  static func getThumbnails(_ json: JSON) -> [Thumbnail] {
    var thumbnails: [Thumbnail] = []

    for (_, index) in json {
      let thumbnail = Thumbnail(json: index)
      thumbnails.append(thumbnail)
    }
    return thumbnails
  }
}
