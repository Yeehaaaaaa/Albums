//
//  Network.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

final class Network {

  // *********************************************************************
  // MARK: - Properties
  fileprivate let baseUrl: String = "https://jsonplaceholder.typicode.com/"
  fileprivate var requestParameters: RequestParameters!


  // *********************************************************************
  // MARK: - Access
  func request(_ requestParameters: RequestParameters, completion: @escaping (Result<JSON>) -> Void) {

    self.requestParameters = requestParameters
    sendRequest() { result in
      completion(result)
    }
  }

  // *********************************************************************
  // MARK: - Request
  fileprivate func sendRequest(_ completion: @escaping (Result<JSON>) -> Void) {
    let request = initRequest()

    if let url = request.request?.urlRequest {
      print(url)
    }
    request.validate().responseJSON { response in
      switch response.result {
      case .success:
        let json = JSON(response.result.value!)
        completion(Result.success(json))
      case .failure:
        guard let statusCode = response.response,
          let data = response.data else {
            let error = NSError(domain: "albums.ios.albums", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Alamofire failed"])
            completion(Result.failure(RequestError.failure(error)))
            return
        }

        let json = JSON(data: data)
        let error = NSError(domain: "albums.ios.albums", code: statusCode.statusCode, userInfo: [NSLocalizedDescriptionKey: json["error"].stringValue])

        completion(Result.failure(RequestError.failure(error)))
      }
    }
  }

  // *********************************************************************
  // MARK: - Init
  fileprivate func initRequest() -> Alamofire.DataRequest {

    let manager = SessionManager.default
    let realUrl = baseUrl + requestParameters.path

    return manager.request(realUrl,
                           method: requestParameters.method,
                           parameters: requestParameters.parameters)
  }
}
