//
//  Utils.swift
//  Albums
//
//  Created by Arthur Daurel on 10/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

class Utils {

  static func readJsonFile(_ fileName: String) -> Data? {

    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      let data = try? Data(contentsOf: url)
      return data
    }
    return nil
  }
}
