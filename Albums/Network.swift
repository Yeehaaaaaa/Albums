//
//  Network.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

final class Network {

  // *********************************************************************
  // MARK: - Properties
  fileprivate let baseUrl: String = "http://92.222.18.222:3000/v1/"
  fileprivate var requestParameters: RequestParameters!

  // *********************************************************************
  // MARK: - Constant
  fileprivate let storyBoardName = "Starter"
  fileprivate let controllerIdentitifier = "Starter"
  fileprivate let TRANSITION_ANIMATION_DURATION = 0.3

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
            let error = NSError(domain: "challengesWar.ios.challengesWar", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Alamofire failed"])
            completion(Result.failure(RequestError.failure(error)))
            return
        }

        let json = JSON(data: data)
        let error = NSError(domain: "challengesWar.ios.challengesWar", code: statusCode.statusCode, userInfo: [NSLocalizedDescriptionKey: json["error"].stringValue])

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
