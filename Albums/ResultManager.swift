//
//  ResultManager.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

// *********************************************************************
// MARK: - Enums
enum Result<T> {
  case success(T)
  case failure(Error)
}

enum RequestError: Error {
  case invalidJson
  case failure(NSError)
  case requestAlreadyStart
}
