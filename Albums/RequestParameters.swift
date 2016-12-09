//
//  RequestParameters.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

struct RequestParameters {
  var method: Alamofire.HTTPMethod
  var path: String!
  var parameters: [String: AnyObject]?
  var connection: Bool?

  init(method: Alamofire.HTTPMethod, url: String, parameters: Dictionary<String, AnyObject>) {
    self.method = method
    self.path = url
    self.parameters = parameters
  }
}
